_Author_:  @DimuthuMadushan \
_Created_: 2026/10/02 \
_Updated_: 2026/10/02 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Docusign Monitor.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/docusign/monitor/v3.0/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Add a summary, description and parameter description to the `Api_v1_RealTimeAlerting_GetStream` operation

   - **Original**: The operation had an empty `summary` and `description`, the `organizationId` path parameter had an empty description and the `200` response was described only as `OK`.
   - **Updated**: Summary `Get the monitoring event stream`, a description of the paged event stream, a description of `organizationId`, and a `200` response description stating that a page of events with the next cursor is returned.
   - **Reason**: Generated documentation was empty and the client method comment was uninformative.

2. Fill the empty schema and property descriptions

   - **Original**: Every definition (`UserAgentClientInfo`, `Os`, `Version`, `Device`, `IpAddressLocation`, `StreamResponse`, `StreamingEventRow`, `Browser`) and each of their properties (55 in total) had an empty `description`.
   - **Updated**: Each now has a one-line description. The edits are made in the source spec `openapi.json`, under the original definition names (`Os`, `Version`, `StreamingEventRow`), and carry through align. Properties that are bare `$ref`s keep an empty description, because align drops sibling keywords of a `$ref`. Align also strips the trailing full stop from schema and parameter descriptions, so the aligned spec and generated comments read without it. The `OperatingSystem.family` description reads `Operating system family name.`
   - **Reason**: The generated record types and fields were left without documentation.

3. Restore the server URL and the path prefix removed by align

   - **Original**: Align folded the path prefix into the server, giving `https://api.docusign.com//v1/organizations/{organizationId}` (with a double slash) and the path `/stream`.
   - **Updated**: Server `https://api.docusign.com` and path `/v1/organizations/{organizationId}/stream`, so `organizationId` stays a path parameter of the operation.
   - **Reason**: The folded server URL was malformed and hid a required path parameter from the client method.

4. Rename the operation and schemas for a readable public surface

   - **Original**: Operation `Api_v1_RealTimeAlerting_GetStream`; schemas `Os`, `Version` and `StreamingEventRow`.
   - **Updated**: Operation `getStream`; schemas `OperatingSystem`, `ClientVersion` and `StreamingEvent`. The decisions are persisted in `ai-mappings.json`.
   - **Reason**: The original names were path-encoded or abbreviated.

5. Replace the `Bearer` apiKey security scheme with OAuth 2.0

   - **Original**: Security scheme `Bearer`, an `apiKey` in the `Authorization` header, which made the client take the raw header value.
   - **Updated**: Security scheme `OAuth2` with the authorization code flow, authorization URL `https://account.docusign.com/oauth/auth`, token and refresh URL `https://account.docusign.com/oauth/token`, and scopes `signature` and `impersonation`. The top-level and operation-level `security` entries reference `OAuth2`. The scheme is defined in the source spec (Swagger `oauth2` with the `accessCode` flow) and carries through align, except `refreshUrl`, which Swagger 2.0 cannot express and which has to be added to the aligned spec by hand after each re-align. The client now accepts `http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig`, so a JWT grant access token can be passed as a bearer token.
   - **Reason**: Docusign APIs are authorized with OAuth 2.0 access tokens, and the generated client should support token refresh.

6. Restore open `additionalProperties` on `StreamingEvent.data`

   - **Original**: The source spec declares `additionalProperties: {}`; align narrowed it to `{"type": "object"}` in the aligned spec.
   - **Updated**: `additionalProperties: {}` is set again in `aligned_ballerina_openapi.json`, so the generated field accepts any JSON value.
   - **Reason**: Align artifact. The source spec already has `additionalProperties: {}` and cannot prevent align narrowing it, so the edit is aligned-spec only and has to be reapplied after a re-align.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --license docs/license.txt -o ballerina --client-methods remote
```
Note: The license year is hardcoded to 2024, change if necessary.
