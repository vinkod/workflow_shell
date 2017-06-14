const request = require('request-promise');
const fs = require('fs');
const Command = require('../models/Command');

const endpoint = { short: 'e', long: 'endpoint', description: 'The endpoint URI.' };
const authorization = { short: 'a', long: 'authorization', description: 'The authorization header.' };
const token = { short: 't', long: 'token', description: 'The token to use.' };
const environment = { short: 'v', long: 'environment', description: 'The environment to use, overrides all other options.' };

class TestCandidatestream extends Command {

  static getString() {
    return 'cbtc';
  }

  static getDescription() {
    return 'Takes one argument, the message. Commits all staged changes with the given message.';
  }

  getUsage() {
    let usage = `${TestCandidatestream.getString()} <file(s) to parse and send>\n`;
    usage = usage.concat(Command.format(authorization)).concat('\n');
    usage = usage.concat(Command.format(endpoint)).concat('\n');
    usage = usage.concat(Command.format(environment)).concat('\n');
    usage = usage.concat(Command.format(token)).concat('\n');
    return usage;
  }

  async run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    if (typeof args._ === 'undefined' || args._.length <= 0) {
      console.log('You MUST specify the file containing the JSON to send!');
      this.printHelp();
      return false;
    }

    let inputEndpoint;
    let inputAuthorization;
    let inputToken;

    const inputEnvironment = args[environment.short] || args[environment.long];
    if (inputEnvironment) {
      console.log('Checking environment variables for values.');
      if (inputEnvironment === 'development') {
        inputEndpoint = process.env.WSH_CBTC_DEVELOPMENT_ENDPOINT;
        inputAuthorization = process.env.WSH_CBTC_DEVELOPMENT_AUTHORIZATION;
        inputToken = process.env.WSH_CBTC_DEVELOPMENT_TOKEN;
      } else if (inputEnvironment === 'staging') {
        inputEndpoint = process.env.WSH_CBTC_STAGING_ENDPOINT;
        inputAuthorization = process.env.WSH_CBTC_STAGING_AUTHORIZATION;
        inputToken = process.env.WSH_CBTC_STAGING_TOKEN;
      } else if (inputEnvironment === 'production') {
        inputEndpoint = process.env.WSH_CBTC_PRODUCTION_ENDPOINT;
        inputAuthorization = process.env.WSH_CBTC_PRODUCTION_AUTHORIZATION;
        inputToken = process.env.WSH_CBTC_PRODUCTION_TOKEN;
      } else {
        throw new Error(`Unknown environment: ${inputEnvironment}`);
      }
    } else {
      inputEndpoint = args[endpoint.short] || args[endpoint.long];
      if (!inputEndpoint) {
        console.log('You MUST specify the endpoint URI to use!');
        this.printHelp();
        return false;
      }

      inputAuthorization = args[authorization.short] || args[authorization.long];
      if (!inputAuthorization) {
        console.log('You MUST specify the authorization to use!');
        this.printHelp();
        return false;
      }

      inputToken = args[token.short] || args[token.long];
      if (!inputToken) {
        console.log('You MUST specify the proxy secret token to use!');
        this.printHelp();
        return false;
      }
    }

    for (const fileName of args._) {
      try {
        console.log(`Sending ${fileName}`);
        const json = JSON.parse(fs.readFileSync(fileName).toString());

        const options = {
          method: 'POST',
          uri: inputEndpoint,
          headers: {
            'x-3scale-proxy-secret-token': inputToken,
            authorization: inputAuthorization
          },
          body: json,
          json: true
        };

        const response = await request(options);
        console.log(`Emails: ${json.candidate.email}`);
        console.log(`${JSON.stringify(response, null, 2)}`);
      } catch (error) {
        console.log('An error occured');
        console.log(`Message: ${error.message}`);
        console.log(`Stack: ${error.stack}`);
      }
    }

    return true;
  }
}

module.exports = TestCandidatestream;
