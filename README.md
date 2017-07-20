Cosmetrics is a full-fledged web application that I created during my time at Launch Academy. The purpose of this challenge was to create an application to allow users to add new items and write reviews for those items.

Cosmetrics is an application that allows it's users to review cosmetic products.

### Challenge Requirements

* The ability to add an item to be reviewed.
* The ability to rate (score on a scale) the item and to optionally comment on it (i.e. write a review).
* The ability to upvote or downvote a review. A user can only upvote or downvote once and can change their vote from up to down. This feature should utilize AJAX so that a complete page reload isn't necessary.
* A sign up and authentication system for your users (with Devise).
* An ability to upload a profile photo (with Carrierwave).
* The ability to search for items.
* An admin role. Admins are able to delete reviews or items if they are deemed to be inappropriate.
* An email is sent to the owner of an item when a new review is posted about it.
* Pagination (with Kaminari).

### To Recreate this Application

Create a new rails app with postgres and rspec with the following steps:
- Create a empty directory with your app name
- Run this in the root of that directory: `rails new . --database=postgresql --skip-turbolinks --skip-test-unit -T` && `bundle`
- `rake db:create`
- Be sure you have the following gems in the Gemfile:

```ruby
gem 'foundation-rails'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl'
  gem 'valid_attribute'
  gem 'shoulda-matchers', require: false
end
```

- `bundle` the new added gems and install rspec `rails generate rspec:install`

### User Authentication

Very often, the first place we'll start when writing an app is the `User` model.
Most of our apps will require users to create accounts and login to access many
of the key features.

#### Authentication Implementation

In Rails, we can use a gem called
[Devise](https://github.com/plataformatec/devise) to create our `User` model for
us.  It takes care of user authentication, security, forgotten passwords, and
the like.  Devise is widely used and well-tested, so we shouldn't need to worry
about the security of our users' data.

Get started adding devise by following the Devise guides
[here](https://github.com/plataformatec/devise#getting-started).

## User Stories Addressed in this Application

#### Authentication User Stories

Cosmetrics fulfills the following user stories, and has thorough
acceptance tests to be sure functionality is always working properly:

```no-highlight
As a prospective user
I want to create an account
So that I can post items and review them
```

```no-highlight
As an unauthenticated user
I want to sign in
So that I can post items and review them
```

```no-highlight
As an authenticated user
I want to sign out
So that no one else can post items or reviews on my behalf
```

```no-highlight
As an authenticated user
I want to update my information
So that I can keep my profile up to date
```

```no-highlight
As an authenticated user
I want to delete my account
So that my information is no longer retained by the app
```

#### CRUD User Stories

* Create

```no-highlight
As an authenticated user
I want to add an item
So that others can review it
```

* Read

```no-highlight
As an authenticated user
I want to view a list of items
So that I can pick items to review
```

```no-highlight
As an authenticated user
I want to view the details about an item
So that I can get more information about it
```

* Update

```no-highlight
As an authenticated user
I want to update an item's information
So that I can correct errors or provide new information
```

* Delete

```no-highlight
As an authenticated user
I want to delete an item
So that no one can review it
```

### Voting

* A user can vote on a review
* A user can change their vote
* A user can delete their vote

A user is only able to vote once per review.

### Administrators

Any user with the role of "admin" assigned to them, has the ability to delete inappropriate
items or reviews, or obnoxious users' accounts.

* An admin views a list of users
* An admin deletes a user
* An admin deletes an item
* An admin deletes a review

### Profile Photos

Use the [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) gem to
allow users to upload profile photos when they create or edit their accounts.
We'll use Carrierwave in combination with the [fog](https://github.com/fog/fog)
gem to allow us to save profile photos on Amazon S3.


### Pagination

Add pagination to the application to limit the number of items or reviews that
are displayed on a single page. Use
[Kaminari](https://github.com/amatsuda/kaminari) to paginate your items' index
page and the reviews on your items' show pages, as well as anywhere else in your
app that you think it would be useful.

### Search

Add a search bar that allows users to search for items.

Write a user story and acceptance criteria for this feature.

Take some time to try to figure out how to do this on your own.

If you're stuck, consult past Sinatra apps that had search functionality, or
[this Railscast](http://railscasts.com/episodes/37-simple-search-form) or [this
blog article](http://www.stefanosioannou.com/rails-4-simple-search-form/).

### Email

Integrate email into your app using ActionMailer. Email the user who posted an
item when someone posts a review of that item.  (Alternatively, or in addition,
email reviewers when their reviews are up- or downvoted.)
