"use strict";

exports.handler = (event, context, callback) => {
  // Get request and request headers
  const request = event.Records[0].cf.request;
  const headers = request.headers;

  // Skip basic auth for fonts, otherwise fonts can't be loaded cross domain for some
  // reason the CSS guys decided to always load fonts in anonymous mode when loaded from
  // a CSS file. This is only for fonts, not images.
  if (/\.(eot|ttf|woff|woff2)$/i.test(request.uri)) {
    callback(null, request);
  }

  // Configure authentication
  const authStrings = [];
  for (let authString of JSON.parse(`${authentication}`)) {
    authStrings.push("Basic " + new Buffer(authString).toString("base64"));
  }

  // Require Basic authentication
  if (
    typeof headers.authorization == "undefined" ||
    authStrings.indexOf(headers.authorization[0].value) == -1
  ) {
    const body = "Unauthorized";
    const response = {
      status: "401",
      statusDescription: "Unauthorized",
      body: body,
      headers: {
        "www-authenticate": [{ key: "WWW-Authenticate", value: "Basic" }]
      }
    };
    callback(null, response);
  }

  // Continue request processing if authentication passed
  callback(null, request);
};
