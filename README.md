# Weekly Birthdays

This small app displays birthdays in the current week for all people tied to
a client. It show their name, age, date of birth and the day of the week
their birthday falls on.

A working site can be viewed at https://norman-frontdesk-test.herokuapp.com.

## Instructions
Assuming access to a collection of people and their birth dates, write a service that returns a list of people with birthdays in the current calendar week. Include person name, name of the day in the week their birthday falls upon, and the age they’re turning.

## Installation
First install all necessary gems:

```bundle install```

Create the database:

```bundle exec rake db:migrate```

Seed the database with one client and people

```bundle exec rake db:seed```

## Testing
To run tests first set up the test database:

```bundle exec rake db:test:prepare```

Then to run through all specs:

```bundle exec rspec```

or to run tests for each change:

```bundle exec guard```

## Features
- Clients can be configured to have their start day on Sunday or Monday (actually
they can have any day of the week). This will show birthdays for the week
based on the start day.
- Birthday object to easily get age and current birthday for a birth date
- Decorator to customize JSON returned for people's birthdays
- Weekly Birthday query object that can have different Person relations
passed in to customize
- Angular.js app to view all weekly birthdays from start of week to end of week

## Want List
List of things to with more time and how I would go about finishing them

- Paging of weekly birthdays in case there are a lot for one client
  - Would need a paging service that would limit and offset sql query
  - Controller would page based on `:offset` and `:limit` params
  - Front end would either have button to show more birthdays or detect
  scroll near the bottom and load automatically
- Create SQL query to find weekly birthdays instead of using Ruby
  - Could store day of year birthday falls on in database
  - Need to figure out issues with leap year
  - Need to figure out what to do at the end of year

