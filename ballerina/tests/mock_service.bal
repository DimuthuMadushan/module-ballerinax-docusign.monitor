// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

listener http:Listener ep0 = new (9090);

@http:ServiceConfig {treatNilableAsOptional: true}
service /v1/organizations on ep0 {
    # Get the monitoring event stream
    #
    # + organizationId - The unique identifier of the organization whose events are retrieved
    # + cursor - A location in the DataSet that continues querying data
    # + 'limit - Maximum number of results to return
    # + return - A page of monitoring events together with the cursor for the next page
    resource function get [string organizationId]/'stream(string? cursor, int:Signed32? 'limit) returns StreamResponse {
        return {
            resultData: [
                {
                    eventId: "9f1c2d7a-5b0e-4c1e-8a57-3d2f6a9b1c40",
                    organizationId,
                    accountId: "2f8b6c1d-7a3e-4f52-9d10-5e6a8c4b7a21",
                    userId: "b7d2c9e4-1a65-4f38-8c0b-6d9e3a5f2c17",
                    timestamp: "2026-09-30T10:15:42.318Z",
                    action: "Login",
                    result: "Success",
                    'source: "Docusign",
                    ipAddress: "203.0.113.42",
                    country: "United States",
                    state: "California",
                    city: "San Francisco",
                    latitude: 37.7749,
                    longitude: -122.4194,
                    browser: "Chrome",
                    os: "macOS",
                    device: "Desktop",
                    userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 Chrome/118.0 Safari/537.36",
                    isUserMemberOfDomain: true,
                    userAgentClientInfo: {
                        os: {family: "macOS", version: {major: "14", minor: "6", patch: "1"}},
                        browser: {family: "Chrome", version: {major: "118", minor: "0", patch: "0"}},
                        device: {family: "Mac", brand: "Apple", model: "MacBook Pro"}
                    },
                    ipAddressLocation: {country: "United States", state: "California", city: "San Francisco", latitude: 37.7749, longitude: -122.4194}
                },
                {
                    eventId: "4c7e1a9b-2d36-4b80-a5f1-9e0c7d3b6a58",
                    organizationId,
                    accountId: "2f8b6c1d-7a3e-4f52-9d10-5e6a8c4b7a21",
                    userId: "b7d2c9e4-1a65-4f38-8c0b-6d9e3a5f2c17",
                    timestamp: "2026-09-30T10:21:07.904Z",
                    action: "Update",
                    result: "Success",
                    'object: "Envelope",
                    property: "Status",
                    ipAddress: "203.0.113.42",
                    isUserMemberOfDomain: true
                }
            ],
            endCursor: "MjAyNi0wOS0zMFQxMDoyMTowNy45MDRa"
        };
    }
}
