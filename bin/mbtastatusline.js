#!/usr/local/bin/node

// TODO: Failure mode testing (no data access, no wifi network, etc.)
// TODO: Coloring based on time interval
// sys exit 1

var fs = require('fs');

// Cache lasts three minutes
var CACHE_DURATION = 180 * 1000;
var CACHE_FILE = "/usr/local/var/mbtastatuscache";

// Main entry
fs.stat(CACHE_FILE, function(err, stat) {
  if (err) return updateCache();

  var now = new Date().getTime();
  if (now - stat.ctime.getTime() > CACHE_DURATION) return updateCache();

  fs.readFile(CACHE_FILE, function(err, content) {
    if (err) throw err;
    formatOutput(content);
  });
});

function updateCache() {
  var exec = require('child_process').exec;

  exec("networksetup -getairportnetwork en0", function(err, stdout, stderr) {
    // TODO: ip range fallback for wired connections?
    if (err || stderr || stdout.lastIndexOf("Current Wi-Fi Network: ") !== 0) {
      console.log("No wifi network access");
      return;
    }
    // Strip "Current Wi-Fi Network: " prefix off the output
    var networkName = stdout.slice(23).trim();
    requestMBTAStatus(networkName);
  });
}


function formatOutput(content) {
  // TODO: Configure this better for proper mode retrieval.
  var moment = require("moment");
  var res = JSON.parse(content);
  var trips = res.mode[0].route[0].direction[0].trip.slice(0, 3);

  // Build output string
  var output = res.stop_name;
  trips.forEach(function(n, i) {
    // TODO: Better string building/formatting.  Really.
    var fromNow = moment.unix(n.pre_dt).fromNow();
    output += i === 0 ? ": " : ", ";
    output += fromNow.lastIndexOf("in ") === 0 ? fromNow.slice(3) : fromNow;
  });
  if (res.alert_headers.length) {
    output += "; " + res.alert_headers.length + " alerts!";
  }
  console.log(output);
}

// Determine the station from our config file
function requestMBTAStatus(networkName) {
  var request = require("request");
  var url = require("url");

  // Given a network name, read our configuration file to
  var config = JSON.parse(
    fs.readFileSync(process.env.HOME + '/.mbtastatusrc', 'utf8')
  );
  if (! config[networkName]) {
     console.log("No station preference for network: " + networkName);
     return;
  }

  // Hit the MBTA API for the predicted stops
  var reqResource = {
    "protocol": "http",
    "host": "realtime.mbta.com",
    "pathname": "/developer/api/v2/predictionsbystop",
    "query": {
      "api_key": process.env.MBTA_API_KEY,
      "stop": config[networkName], // "70092"
      "format": "json"
    }
  };
  request(url.format(reqResource), function(err, meta, body) {
    if (err) {
      console.log("No data access");
      return;
    }
    // Cache the object and print out the result
    fs.writeFile(CACHE_FILE, body, function(err) {
      if (err) throw err;
      formatOutput(body);
    });
  });
}
