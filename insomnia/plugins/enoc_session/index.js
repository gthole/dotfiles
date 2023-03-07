/*
 * For work - automatically add session headers across workspaces
 */
const sessionStore = {};

function setSession(context) {
    let env = context.request.getEnvironment().getKeysContext().keyContext['_.host'];
    env = env === 'local' ? 'dev' : env; // Use "dev" if we're talking to a local env
    if (sessionStore[env]) {
        context.request.setHeader('enoc_session', sessionStore[env]);
    }
}

async function getSession(context) {
    const url = context.request.getUrl();
    const env = context.request.getEnvironment().getKeysContext().keyContext['_.host'];
    if (!['dev', 'preprd', 'prd'].includes(env)) {
        return;
    }
    if (url.endsWith(`/api/v4/sessions/login`)) {
        const raw = context.response.getBody();
        const body = JSON.parse(raw.toString());
        sessionStore[env] = body?.data?.enoc_session;
    }
}

module.exports.requestHooks = [setSession];
module.exports.responseHooks = [getSession];
