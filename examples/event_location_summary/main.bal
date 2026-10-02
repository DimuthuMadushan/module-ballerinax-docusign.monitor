import ballerina/io;
import ballerinax/docusign.monitor;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string organizationId = ?;
configurable int pageSize = 100;
configurable int maxPages = 10;

public function main() returns error? {
    monitor:Client monitorClient = check new ({
        auth: {
            clientId,
            clientSecret,
            refreshToken
        }
    });

    map<int> eventsByCountry = {};
    map<map<boolean>> addressesByCountry = {};
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
        if events.length() == 0 {
            break;
        }
        foreach monitor:StreamingEvent event in events {
            string country = event?.country ?: event?.ipAddressLocation?.country ?: "Unknown";
            eventsByCountry[country] = (eventsByCountry[country] ?: 0) + 1;
            string? address = event?.ipAddress;
            if address is string {
                map<boolean> addresses = addressesByCountry[country] ?: {};
                addresses[address] = true;
                addressesByCountry[country] = addresses;
            }
        }
        cursor = page?.endCursor;
        if cursor is () {
            break;
        }
    }

    io:println("Pages read: ", pagesRead);
    foreach [string, int] [country, count] in eventsByCountry.entries() {
        int distinctAddresses = (addressesByCountry[country] ?: {}).length();
        io:println(country, ": ", count, " events from ", distinctAddresses, " distinct IP addresses");
    }
}
