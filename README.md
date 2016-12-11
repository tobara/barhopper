![Build Status](https://codeship.com/projects/739c27a0-9d30-0133-8551-4a8fb09a0dfa/status?branch=master)
![Code Climate](https://codeclimate.com/github/tobara/barhopper.png)
![Coverage Status](https://coveralls.io/repos/tobara/barhopper/badge.png)

## Rewrite Check-list
* [½] Refactor Bar model
* [X] Add links to Bar DB table (popular_query column)
* [X] Download all popular times for a newly added bar ~~and store in CSV file to avoid blocking by
      google.~~ Create Days_table.  Download each day when queried (that day) and store in db.
  [X] Remove popular_time column from bars table
  [X] Add popular_query column to bars table
* []  Refactor mobile functionality
* [X] Scrape the time the bar opens to determine how many popular times to import for a given day.
* [X] Confirm tests are passing again.
