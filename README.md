# Ballerina Docusign Monitor connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-docusign.monitor.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/docusign.monitor.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fdocusign.monitor)

## Overview

[Docusign](https://www.docusign.com/) is an agreement management platform for preparing, signing, acting on and managing agreements. [Docusign Monitor](https://developers.docusign.com/docs/monitor-api/) provides security and compliance teams with visibility into account activity by exposing the events that occur in an organization as a continuous data set.

The Docusign Monitor connector lets Ballerina applications read the organization event stream and page through it with a cursor. It supports version 3.0 of the Docusign Monitor API.

## Setup guide

To use the Docusign Monitor connector, you need a Docusign organization with Docusign Monitor enabled and an app that is authorized to call the Monitor API using OAuth 2.0.

### Step 1: Create an integration key

1. Sign in to the [Docusign Developer Console](https://developers.docusign.com/) and open your apps and keys page.
2. Create an app and note down its **Integration Key**, which is the client ID.
3. Add a **secret key** to the app and note it down, which is the client secret.
4. Add the redirect URI that your application uses.

### Step 2: Obtain a refresh token

1. Direct the user to the Docusign authorization endpoint, replacing `CLIENT_ID` and `REDIRECT_URI`. Use `account-d.docusign.com` instead of `account.docusign.com` for the demo environment.

```
https://account.docusign.com/oauth/auth?response_type=code&scope=signature%20impersonation%20extended&client_id=CLIENT_ID&redirect_uri=REDIRECT_URI
```

2. After the user grants consent, Docusign redirects to your redirect URI with an authorization code.
3. Exchange the authorization code for tokens.

```curl
curl -X POST https://account.docusign.com/oauth/token \
  -H "Authorization: Basic $(echo -n 'CLIENT_ID:CLIENT_SECRET' | base64)" \
  -d "grant_type=authorization_code&code=AUTHORIZATION_CODE"
```

This returns both an `access_token` and a `refresh_token`. If your application authenticates with the JWT grant instead, pass the resulting access token as a bearer token.

### Step 3: Find your organization ID

1. Open the Docusign Admin console of your organization.
2. Copy the **Organization ID** shown in the organization details. It identifies the organization whose events you read.

## Quickstart

To use the Docusign Monitor connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `docusign.monitor` module.

```ballerina
import ballerinax/docusign.monitor;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the values obtained in the steps above:

```toml
clientId = "<Client ID>"
clientSecret = "<Client Secret>"
refreshToken = "<Refresh Token>"
organizationId = "<Organization ID>"
```

2. Create a `monitor:ConnectionConfig` with the OAuth 2.0 refresh token grant credentials and initialize the connector with it.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string organizationId = ?;

final monitor:Client monitorClient = check new ({
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Read a page of the organization event stream

```ballerina
public function main() returns error? {
    monitor:StreamResponse _ = check monitorClient->getStream(organizationId);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The Docusign Monitor connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/tree/main/examples/), covering the following use cases:

1. [User activity audit](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/tree/main/examples/user_activity_audit) - Page through the organization event stream, collect the events of one user and count them by action.

2. [Event location summary](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/tree/main/examples/event_location_summary) - Page through the organization event stream and summarize events and distinct IP addresses by country.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`docusign.monitor` package](https://central.ballerina.io/ballerinax/docusign.monitor/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
