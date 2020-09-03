# Rails Engine
Rails Engine is an Application Programming Interface for an e-commerce platform.
This API delivers business intelligence that is presented in a front-end website.

It is my mid-term solo project for Mod 3 Backend at the Turing School.

## Setup

Versioning: `ruby '2.5.3'` and `rails 5.2.4`.

This repo is just the API backend. [There is a front-end in a different repo.](https://github.com/turingschool-examples/rails_driver) You don't have to use the front-end repo in order to access this API.

The Rails Engine API can be consumed by any HTTP client. I recommend using Insomnia.

At the very least, you will be able to use your preferred web browser to visit any `GET` endpoints.

### Rails Engine Installation

```
git clone git@github.com:ajtran303/rails_engine.git
cd rails_engine
bundle install
bundle exec rake db:{create,migrate}
bundle exec rake import_csv
bundle exec rspec
rails s -p 3000
```

## Endpoints

All requests are sent to
```
http://localhost:3000/api/v1
```

### CRUD Endpoints

Items CRUD API
```
# Get the index
GET http://localhost:3000/api/v1/items

# Get one record
GET http://localhost:3000/api/v1/items/:id

# Create a new record
# Update an existing record

# Destroy an existing record
DELETE http://localhost:3000/api/v1/items/:id
```

Merchants CRUD API
```
# Get the index
GET http://localhost:3000/api/v1/merchants

# Get one record
GET http://localhost:3000/api/v1/merchants/:id

# Create a new record
# Update an existing record

# Destroy an existing record
DELETE http://localhost:3000/api/v1/items/:id
```

### Relationships

```
# Get the merchant of an item
GET http://localhost:3000/api/v1/items/:id/merchant

# Get the items of a merchant
GET http://localhost:3000/api/v1/merchants/:id/items
```

### Find Endpoints

Items Find API
```
# Single Finders - Retrieve one record
# Multi Finders - Retrieve many records

# Search by attributes:
# name (see note)
# description (see note)
# unit_price
# timestamps

```

Merchants Find API

```
# Single Finders - Retrieve one record
# Multi Finders - Retrieve many records

# Search by attributes:
# name (see note)
# timestamps

```

NOTE: searching by name or description attributes is gracious. The API will accept "fragmented" queries and will treat such queries case non-sensitive.

### Business Intelligence Endpoints

```
# Merchants with Most Revenue
GET http://localhost:3000/api/v1/merchants/most_revenue?quantity=x

# Merchants with Most Items Sold
GET http://localhost:3000/api/v1/merchants/most_items?quantity=x

# Revenue across Date Range
GET http://localhost:3000/api/v1/revenue?start=<start_date>&end=<end_date>

# Revenue for a Merchant
GET http://localhost:3000/api/v1/merchants/:id/revenue
```

## Known Issues

- The `import_csv` Rake task will normally take some time during `invoice_items`
- This README is still being updated
- Happy Path Only (200, 204)! Next steps: Sad path (404?) and edge case testing
- Need unit tests for ActiveRecord Queries in Item and Merchant models
