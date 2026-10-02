# User Activity Audit

This example reads the Docusign Monitor event stream of an organization page by page and collects the events performed by a single user. It then prints how many times the user performed each action, which helps when reviewing the activity of one account.

## Prerequisites

- Create a `Config.toml` in this directory:
  ```toml
  clientId = "<client-id>"
  clientSecret = "<client-secret>"
  refreshToken = "<refresh-token>"
  organizationId = "<organization-id>"
  auditedUserId = "<user-id>"
  pageSize = 100
  maxPages = 10
  ```

## Run the example

```bash
bal run
```
