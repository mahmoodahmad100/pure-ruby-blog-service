# Pure Ruby Blog Service
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

### Description:
The aim of the project is to create a blog service that can be consumed by client side (frontend, mobile app ..etc) or third party systems.

### Technical Reasoning:
The app is built on Ruby and it implements best practices like applying `SOLID` principles, `OOP` and `OOD`.

### Trade-offs:
if I was to spend additional time on the project I would do the following:
* Improve the the current tests
* Finish the worker feature
* Optimize `ip_addresses_info` in the post model (app/models/post.rb ... starting line is 47)
* Make the `feedbackable` method (app/controllers/feedbacks_controller.rb ... ln: 18:24) more scalable as it's currently coupled to 2 relations (user & post)
* Handle the duplicate implementations of the class mapping (for polymorphism relations) in the post & user models
* Use [Vitess](https://vitess.io) (horizontal scaling of MySQL)
* Dockerize the project
### Getting started:

* Open the terminal and navigate to the project directory and run `bundle install`
* You do not have a `.env` file in the project root directory so copy `.env.example` and save it as `.env`
* In `.env` file update the database info
* Create the database tables by running `bundle exec rake db:migrate`
* Seed the database by running `bundle exec rake db:seed`

### Usage:

after applying what's in `Getting started` section, you can now start the server by running:

```
bundle exec rackup
```

**note**: you can find the server at: `http://localhost:9292`

### Testing & Development:
* You can run the tests by running `bundle exec rspec .` also you can test the APIs manually by importing `postman_collection.json` file into **Postman**

* You can run RuboCop (linter) by running `bundle exec rubocop .`