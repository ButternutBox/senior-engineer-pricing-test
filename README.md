# Architectural Design Tech Test

## Setup

To setup the project you can run the followings steps

```
bundle install
rake db:setup
```

## Tests
The test suite can be run with Rspec

```
bundle exec rspec
```

# Introduction
This rails application is a very basic implementation of a headless E-Commerce system. The system may be interacted with via multiple clients, such as a RESTful Admin interface, a GraphQL layer, or extracted through data pipelines for analysis.

### IMPORTANT NOTE
This is a deliberately “open” tech test because we expect experienced engineers to set help set direction and make recommendations that will benefit the company.
Please feel free to make assumptions about things that you might normally check with a product manager or stakeholder. But please explain your thinking if you do.
With that in mind, please treat this test as though it were a real piece of work on a production system and produce a solution that you would be happy to maintain in the future, and which is thoughtful to potential future extensions and analyses.

## The Models

### Skus

Skus represent physical items that we stock. This could be things we sell, packaging, customer gifts etc.

### Products

Products allow us to add a price and a name to SKUs that we want to sell.

### Orders & OrderProducts

An Order is a collection of OrderProducts. Order Products are essentially line items. They contain the product being purchased and the quantity required.

The shipping date is also stored on an Order.

## The Task

We have the ability to change the price of a product. But unfortunately this changes the value of every existing order. Even if they've been shipped already. We would like to be able to change prices without effecting the price totals of existing orders.

** Acceptance Criteria: **

* The price of existing orders must not change
* The price of new orders will use the new price

Please submit your solution via Greenhouse.

## Your Explanation

Option 1:
Embed the details of products ordered at order creation

| Pros                                                                                                                                           | Cons                                                                                        |
|------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| - Optimised for read<br/>- Comprehensive history of products<br/>- Order table can be made 'read-only' to prevent accidental errors in future  | - Increased complexity of order objects<br/>- Any historic changes will be more complicated |

Option 2:
Add versioning to products
Possible via pg?

| Pros                                                                                                                                     | Cons                                                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| - Optimised for writes<br/>Comprehensive history of products and pricing history<br/>Simplified data model with minimal changes required | - Optimisation for write introduces overhead for read, which is likely to be the most common operation on orders<br/>- Harder to implement |

// TOOD migration?