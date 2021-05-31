# Errors

The Data API uses the following error codes:

Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request is invalid.
401 | Unauthorized -- Access token is missing or invalid..
404 | Not Found -- The specified document could not be found.
423 | Locked -- Insufficient credits for the operation.
429 | Too Many Requests -- You're requesting too many documents! Slow down!
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.
