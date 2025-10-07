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

### Solution Overview

To solve the problem of changing prices affecting historical orders, I implemented a **price snapshotting** approach. When an `OrderProduct` is created, the current price of the product is captured and stored in a new column `price_snapshot_in_cents` on the `order_products` table.

### Architectural Design Choices

**1. Database Schema:**
- Added `price_snapshot_in_cents` column to `order_products` table
- This denormalizes the data but ensures historical accuracy

**2. Model Changes:**
- Implemented a `before_save` callback in `OrderProduct` to capture the price
- Updated the `subtotal` method to use `price_snapshot_in_cents` instead of `product.price_in_cents`

**3. Benefits:**
- Simple implementation with minimal code changes
- Existing orders are not affected by product price changes
- New orders automatically capture the current price
- The subtotal calculation is straightforward and fast

**4. Trade-offs:**
- Data duplication (price exists in both `products` and `order_products`)
- Slight increase in storage requirements
- Need to ensure the snapshot is captured correctly on every save
