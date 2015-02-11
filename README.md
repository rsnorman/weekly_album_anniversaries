# Weekly Anniversaries

This small app displays Anniversaries in the current week for Best New
Music albums reviewed by Pitchfork. It show their name, artist, age, and release date
their Anniversary falls on.

A working site can be viewed at https://weekly-album-anniversaries.herokuapp.com.

## Installation
First install all necessary gems:

```bundle install```

Create the database:

```bundle exec rake db:migrate```

Seed the database with one genre and albums

```bundle exec rake db:seed```

## Testing
To run tests first set up the test database:

```bundle exec rake db:test:prepare```

Then to run through all specs:

```bundle exec rspec```

or to run tests for each change:

```bundle exec guard```

## Features
- Anniversary object to easily get age and current Anniversary for a
  release date
- Decorator to customize JSON returned for albums's anniversaries
- Weekly anniversary query object that can have different album relations
passed in to customize
- Angular.js app to view all weekly anniversaries from start of week to end of week

## Want List
List of things to with more time and how I would go about finishing them

- Paging of weekly anniversaries in case there are a lot for one genre
  - Would need a paging service that would limit and offset sql query
  - Controller would page based on `:offset` and `:limit` params
  - Front end would either have button to show more Anniversaries or detect
  scroll near the bottom and load automatically
  - The JSON response would also no longer be an array but an object with a
  summary which contains an array of anniversaries. Below is a quick idea of what
  this response may look like.

```
{
  "week": 4,
  "offset": 50,
  "limit":  25,
  "total":  150,
  "next_url": "/v1/anniversaries?offset=25&limit=25",
  "prev_url": "/v1/anniversaries?offset=75&limit=25",
  "anniversaries": [...]
}
```

- Create SQL query to find weekly anniversaries instead of using Ruby
  - Could store day of year anniversary falls on in database
  - Need to figure out issues with leap year
  - Need to figure out what to do at the end of year
