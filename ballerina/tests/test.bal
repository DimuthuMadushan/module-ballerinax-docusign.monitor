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
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.docusign.com" : "http://localhost:9090";
final string token = isLiveServer ? os:getEnv("DOCUSIGN_ACCESS_TOKEN") : "test_token";
final string organizationId = isLiveServer ? os:getEnv("DOCUSIGN_ORGANIZATION_ID") : "7c1f0b52-8d3a-4e69-b4a7-2f5d9e8c1a30";

final Client docusignMonitor = check new ({auth: {token}, httpVersion: isLiveServer ? http:HTTP_2_0 : http:HTTP_1_1}, serviceUrl);

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetStream() returns error? {
    StreamResponse response = check docusignMonitor->getStream(organizationId);
    test:assertTrue(response?.resultData !is ());
    test:assertTrue(response?.endCursor !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetStreamWithQueries() returns error? {
    StreamResponse response = check docusignMonitor->getStream(organizationId, 'limit = 2);
    StreamingEvent[] events = response?.resultData ?: [];
    test:assertTrue(events.length() > 0);
}
