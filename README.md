# Weekly Anniversaries

This small app displays Anniversaries in the current week for all albums tied to
a genre. It show their name, age, date of birth and the day of the week
their Anniversary falls on.

A working site can be viewed at https://norman-frontdesk-test.herokuapp.com.

## Instructions
Assuming access to a collection of albums and their birth dates, write a service that returns a list of albums with Anniversaries in the current calendar week. Include album name, name of the day in the week their Anniversary falls upon, and the age they’re turning.

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
- Genres can be configured to have their start day on Sunday or Monday (actually
they can have any day of the week). This will show Anniversaries for the week
based on the start day.
- Anniversary object to easily get age and current Anniversary for a birth date
- Decorator to customize JSON returned for albums's Anniversaries
- Weekly Anniversary query object that can have different album relations
passed in to customize
- Angular.js app to view all weekly Anniversaries from start of week to end of week

## Want List
List of things to with more time and how I would go about finishing them

- Paging of weekly Anniversaries in case there are a lot for one genre
  - Would need a paging service that would limit and offset sql query
  - Controller would page based on `:offset` and `:limit` params
  - Front end would either have button to show more Anniversaries or detect
  scroll near the bottom and load automatically
  - The JSON response would also no longer be an array but an object with a
  summary which contains an array of Anniversaries. Below is a quick idea of what
  this response may look like.

```
{
  "week": 4,
  "offset": 50,
  "limit":  25,
  "total":  150,
  "next_url": "/v1/Anniversaries?offset=25&limit=25",
  "prev_url": "/v1/Anniversaries?offset=75&limit=25",
  "Anniversaries": [...]
}
```

- Create SQL query to find weekly Anniversaries instead of using Ruby
  - Could store day of year Anniversary falls on in database
  - Need to figure out issues with leap year
  - Need to figure out what to do at the end of year

