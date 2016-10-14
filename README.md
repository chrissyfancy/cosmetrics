Seph-ake-a Reviews, a spin-off of Sephora.com, is a fully fleged web application that I created during my time at Launch Academy. The purpose of this challenge was to create an application to allow users to add new items and write reviews for those items.

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

### Create Application

Create a new rails app with postgres and rspec with the following steps:
- Create a empty directory with your app name
- Run this in the root of that directory: `rails new . --database=postgresql --skip-turbolinks --skip-test-unit -T` && `bundle`
- `rake db:create`
- Be sure you have the following gems in the Gemfile:

Note: the `rails new` generated gemfile has many commented lines/gems. You can
always get these back by `rails new'ing` a new project and lookin at that
projects gemfile so its much cleaner to delete all these commented lines of code
after you've created your Gemfile.  

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

#### Authentication User Stories

Your implementation should fulfill the following user stories, add the necessary
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

#### User Stories

In a standard CRUD app, each of these CRUD operations will correspond to one
(or, for "read", two) user stories:

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

Write user stories and acceptance criteria to cover the following situations:

* A user votes on a review
* A user changes their vote
* A user deletes their vote

Make sure a user can only vote once per review.

**DO NOT USE** the `act_as_votable` gem to implement this feature. As before,
start by checking out a new feature branch.  Write a controller test, make the
test pass, and repeat until your user stories are complete.  Create a Pull
Request containing your completed code.

### Administrators

Many web apps have separate admin sections that allow admins to perform tasks
that regular users cannot. Let's give admins the ability to delete inappropriate
items or reviews, or obnoxious users' accounts.

Write user stories and acceptance criteria to cover the following situations:

* An admin views a list of users
* An admin deletes a user
* An admin deletes an item
* An admin deletes a review

Follow the git and TDD workflow you've established when completing prior features.

#### Hints

There are two general approaches to implementing admin functionality: add
conditional statements to existing views and controllers to check for admin
privileges or define a separate set of views/controllers only accessible to
admins.

Adding conditional checks for admins to existing views may look something like:

```html
<% @items.each do |item| %>
  <!-- some stuff here -->

  <% if current_user.admin? %>
    <%= button_to 'Delete', item, method: :delete %>
  <% end %>
<% end %>
```

Merely hiding a button or creating a separate view does not prevent malicious
users from performing admin-only actions, such as triggering our
`ItemsController#destroy` action. Malicious users could still delete records by
sending hand-crafted HTTP requests to delete the record directly. Ensure that
you have the appropriate checks in your controller to ensure that the
authenticated user has the appropriate permissions to perform certain actions.

An alternative is to using **namespacing** to define a set of routes and
controllers that are only accessible to admin users:

```ruby
namespace :admin do
  resources :items
end
```

With separate controllers and views you can simplify the authorization checks by
only allowing admins to view any portion of the page.

### Profile Photos

Use the [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) gem to
allow users to upload profile photos when they create or edit their accounts.
We'll use Carrierwave in combination with the [fog](https://github.com/fog/fog)
gem to allow us to save profile photos on Amazon S3.

If you're feeling ambitious, you can also use Carrierwave to allow users to
upload photos of whatever items your app reviews.

Because we already have user stories for creating and updating user profiles,
you can simply modify those user stories to allow users to optionally provide a
profile photo.

Try to follow the Carrierwave and fog documentation to implement this feature.
Learning to use a new gem by reading the docs is an important skill that you'll
rely on frequently once you finish the program.

#### Hints

You will need to create an Amazon AWS account and an S3 bucket to store the
photos. S3 provides cheap storage and AWS offers free tier for new users of up
to 1GB for a year but they require a credit card to sign up.  You'll then need
to store your AWS credentials and S3 bucket name(s) as environment variables
inside your app using the [dotenv-rails](https://github.com/bkeepers/dotenv)
gem.

**Make sure not to commit these credentials!** If your credentials get pushed to
GitHub and some nefarious person and/or bot gets ahold of them, they can rack up
a nasty bill on your AWS account.

* The dotenv gem will have you store your credentials in a file called `.env`.
  Make sure to add this to your `.gitignore` file before committing so that any
  changes you make to that file (e.g., adding your actual credentials) don't get
  committed and pushed to GitHub.
* Create a file called `.env.example` that contains the names of any environment
  variables a collaborator would need to set in order to use the app.

As an example, you should have the following in your `.gitignore`, `.env`, and
`.env.example` files:

```no-highlight
# in /.gitignore:
/.env

# in /.env:
AWS_ACCESS_KEY_ID=<your actual AWS access key id>
AWS_SECRET_ACCESS_KEY=<your actual AWS secret access key>
S3_BUCKET=<the name of your S3 bucket>

# in /.env.example:
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
S3_BUCKET=
```

### Pagination

Add pagination to the application to limit the number of items or reviews that
are displayed on a single page. Use
[Kaminari](https://github.com/amatsuda/kaminari) to paginate your items' index
page and the reviews on your items' show pages, as well as anywhere else in your
app that you think it would be useful.

Pagination isn't really a new feature, so we don't need separate user stories.
Since we're modifying what users see on the items index and show pages, we can
modify the existing user stories for those pages to add acceptance criteria
regarding how many items are displayed.

Try to follow the Kaminari documentation to implement this feature.  Learning to
use a new gem by reading the docs is an important skill that you'll rely on
frequently once you finish the program.

### Live Updating
Your review item index should live update every 5 seconds. For example, if
I have a browser tab open on the review item index and in another browser tab,
I add a new review item, then I should see the newly added item on the review
item index **without having to refresh the page**.

To accomplish this, create an API endpoint that will serve the review item index
data as JSON. Then create a React component that uses this JSON data to render
the review item index. The component should fetch data from the API endpoint
when it is initially rendered and subsequently fetches the data again every 5
seconds.

### API Integration

Add an API integration that posts activity from your application to another
service on the web.

Write a user story and acceptance criteria for this feature. Suggested behavior
would be to have 'new' reviews post to a Twitter account you create for your
review site application.

Twitter developer docs are [here](https://dev.twitter.com/rest/public). If you
are stuck on how to get started with this, consult past material on how to
'consume' external APIs.

Be sure to tackle the challenge of how you will build tests for this (both unit
and acceptance level tests).

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

Write a user story and acceptance criteria for this feature.

**NOTE:** When you deploy to Heroku, you'll need to set up an add-on to allow
you to send email in production using ActionMailer.  We recommend
[Mandrill](https://devcenter.heroku.com/articles/mandrill).
