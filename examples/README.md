# Examples

The `ballerinax/docusign.monitor` connector provides practical examples illustrating usage in various scenarios.

1. **[User activity audit](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/tree/main/examples/user_activity_audit)** - Page through the organization event stream, collect the events of one user and count them by action.

2. **[Event location summary](https://github.com/ballerina-platform/module-ballerinax-docusign.monitor/tree/main/examples/event_location_summary)** - Page through the organization event stream and summarize events and distinct IP addresses by country.

## Prerequisites

1. Generate Docusign credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/docusign.monitor/latest#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your Config.toml file should look:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
organizationId = "<organization-id>"
```

Each example lists the additional values it needs in its own README.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
