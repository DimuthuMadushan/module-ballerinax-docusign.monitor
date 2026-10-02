import ballerina/io;
import ballerinax/docusign.monitor;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string organizationId = ?;
configurable string auditedUserId = ?;
configurable int pageSize = 100;
configurable int maxPages = 10;

public function main() returns error? {
    if pageSize <= 0 || pageSize > int:SIGNED32_MAX_VALUE {
        return error("pageSize must be between 1 and " + int:SIGNED32_MAX_VALUE.toString());
    }
    monitor:Client monitorClient = check new ({
        auth: {
            clientId,
            clientSecret,
            refreshToken
        }
    });

    monitor:StreamingEvent[] userEvents = [];
    string? cursor = ();
    int pagesRead = 0;

    // Read the organization event stream page by page until it is exhausted.
    while pagesRead < maxPages {
        monitor:GetStreamQueries queries = {'limit: <int:Signed32>pageSize};
        if cursor is string {
            queries.cursor = cursor;
        }
        monitor:StreamResponse page = check monitorClient->getStream(organizationId, {}, queries);
        monitor:StreamingEvent[] events = page?.resultData ?: [];
        pagesRead += 1;
        foreach monitor:StreamingEvent event in events {
            if event?.userId == auditedUserId {
                userEvents.push(event);
            }
        }
        string? next = page?.endCursor;
        if next is () || next == "" {
            break;
        }
        // An unchanged cursor means the stream has caught up.
        if next == cursor {
            break;
        }
        cursor = next;
    }

    // Count the audited user's events by action.
    map<int> actionCounts = {};
    foreach monitor:StreamingEvent event in userEvents {
        string action = event?.action ?: "Unknown";
        actionCounts[action] = (actionCounts[action] ?: 0) + 1;
    }

    io:println("Pages read: ", pagesRead);
    io:println("Events for user ", auditedUserId, ": ", userEvents.length());
    foreach [string, int] [action, count] in actionCounts.entries() {
        io:println(action, ": ", count);
    }
}
