# Event Location Summary

This example reads the Docusign Monitor event stream of an organization page by page and groups the events by the country they originated from. For each country it prints the number of events and the number of distinct IP addresses, which helps to spot unexpected access locations.

## Prerequisites

- Create a `Config.toml` in this directory:
  ```toml
  clientId = "<client-id>"
  clientSecret = "<client-secret>"
  refreshToken = "<refresh-token>"
  organizationId = "<organization-id>"
  pageSize = 100
  maxPages = 10
  ```

## Run the example

```bash
bal run
```
