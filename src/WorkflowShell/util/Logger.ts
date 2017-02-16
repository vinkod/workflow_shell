import * as winston from "winston";

export default class Logger {
  className: string;
  logger;

  constructor(className: string) {
    this.className = className;
    this.logger = new (winston.Logger)({
      transports: [
        new (winston.transports.Console)({
          timestamp: function () {
            return new Date().toLocaleDateString();
          },
          formatter: function (options) {
            // Return string will be passed to logger.
            return options.timestamp() + " " +
              className + ": " +
              (options.message ? options.message : "") +
              (options.meta && Object.keys(options.meta).length ?
                "\n\t" + JSON.stringify(options.meta) :
                "");
          }
        })
      ]
    });
  }

  log(message: string) {
    this.logger.info(message);
  }

  logWithMeta(message: string, metadata: any) {
    this.logger.info(message, metadata);
  }
}
