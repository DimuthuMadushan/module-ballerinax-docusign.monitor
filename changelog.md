# Change Log

This file contains all the notable changes done to the Ballerina Docusign Monitor connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Remote method `getStream` to read a page of the organization event stream, with `cursor` and `limit` query parameters.
- Record types `StreamResponse`, `StreamingEvent`, `UserAgentClientInfo`, `OperatingSystem`, `Browser`, `Device`,
  `ClientVersion` and `IpAddressLocation` describing the event stream response.
