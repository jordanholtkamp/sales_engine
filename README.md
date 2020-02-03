# Rails Engine API

Sales Engine is a RESTful API that provides access to 42 unique endpoints built from imported sales data.

Technologies: Ruby on Rails, PostgreSQL, RSpec, ActiveRecord

## Schema Design

<img width="1037" alt="Schema Design Tables" src="https://user-images.githubusercontent.com/46657526/73613887-36445100-45b7-11ea-8634-3baa6a00bb21.png">

## Setting up Rails Engine

1. Clone the latest version @ https://github.com/jordanholtkamp/rails_engine  
2. Navigate inside the `rails_engine` directory and run the following commands in your terminal.
3. Run `bundle install` + `bundle update` + `bundle` to prep the gemfile.
4. Run `rake db:create` + `rake db:migrate` to create the databases.
5. Run `rake customers`, `rake merchants`, `rake items`, `rake invoices`, `rake transactions`, and `rake invoice_items` to import csv data into the databases.
6. Run `bundle exec rspec` to initiate the testing suite and verify the app is ready.
7. Run `rails s` to initiate a local server on your machine.
8. Open your browser and navigate to http://localhost:3000/api/v1 + the desired endpoint. All further described endpoints will be situated after this path.
9. Make sure your Ruby Version is compatible with what is in the `.ruby-version` file.

