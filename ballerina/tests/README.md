# Running Tests

## Prerequisites

To run the tests against the live Docusign Monitor API you need an access token that is authorized to call the Monitor API and the ID of your Docusign organization. Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/blob/main/ballerina/README.md#setup-guide) to obtain them.

## Test environments

There are two test environments. The default is a mock server for the Docusign Monitor API. The other is the live Docusign Monitor API.

 Test Groups | Environment
-------------|------------------------------------------------
 mock_tests  | Mock server for Docusign Monitor API (default)
 live_tests  | Docusign Monitor API

## Running tests against the mock server

No configuration is needed. When `IS_LIVE_SERVER` is not set to `true`, the tests run against the mock server on port `9090`.

```bash
./gradlew clean test
```

## Running tests against the live Docusign Monitor API

Set the following environment variables, then run the tests.

| Variable | Description |
|---|---|
| `IS_LIVE_SERVER` | Set to `true` to target `https://api.docusign.com` instead of the mock server |
| `DOCUSIGN_ACCESS_TOKEN` | OAuth 2.0 access token (bearer token) |
| `DOCUSIGN_ORGANIZATION_ID` | ID of the organization whose event stream is read |

```bash
export IS_LIVE_SERVER=true
export DOCUSIGN_ACCESS_TOKEN="<access-token>"
export DOCUSIGN_ORGANIZATION_ID="<organization-id>"
./gradlew clean test -Pgroups=live_tests
```

## Test coverage

The tests cover the `getStream` operation: reading the first page of the event stream and reading a page with the `limit` query parameter.
