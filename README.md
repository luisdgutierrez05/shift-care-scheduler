# Shift Care Scheduler

## Description
Rails application that is able to schedule events between two parties.

## Requirements

* Rails 7.0.4
* Ruby 3.0.0
* PostgreSQL


## Getting started
To get started with the app, clone the repo and then install the needed gems:

```
$ cd /path/to/repos
$ git clone [shift-care-scheduler](https://github.com/luisdgutierrez05/shift-care-scheduler.git)
$ cd shift-care-scheduler
$ bundle install
```

Next, setup the database:

```
$ cp config/database.yml.sample config/database.yml and add your Postgres settings.
$ rails db:setups
```

To run the app in a local server:

```
$ rails server
```

# Code Overview

## Roles and Permissions
  * Admin
    - Manage Plumbers.
    - Manage Clients.
    - Manage Jobs.


## Endpoints (2)

### Get all jobs assigned to a plumber by date range or status
```
Action: GET
URL: http://localhost:3000/api/v1/jobs
Headers: 'Content-Type': 'application/vnd.api+json'
Body params: {
  "data": {
    "attributes": {
      "plumber_id": 2,
      "start_date": "2022-10-22",
      "end_date": "2022-10-26",
      "status": "pending"
    }
  }
}
```
Response sample: [link](postman/response-samples/jobs/index.json)

### Update job status to Done
```
Action: PUT
URL: http://localhost:3000/api/v1/jobs/2
Headers: 'Content-Type': 'application/vnd.api+json'
Body params: {}
```
Response sample: [link](postman/response-samples/jobs/per_year/update.json)

## Author

* **Luis Gutiérrez**
