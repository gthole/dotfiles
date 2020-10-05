function litbt
    set -gx DOCKER_TLS_VERIFY "1";
    set -gx DOCKER_HOST "tcp://71.162.117.46:2376";
    set -gx DOCKER_CERT_PATH "/Users/greg.thole.old/.docker/machine/machines/apps.litbt.net";
    set -gx DOCKER_MACHINE_NAME "apps.litbt.net";
end
