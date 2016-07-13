# Toritsugi: Yet another redirector for Rails apps
Toritsugi is a Rails Engine for adding simple url redirection feature to your apps.

The gem provides:
* Dynamic redirection rules on DB
* After redirection callbacks

# Requirements
* Ruby 2.3 or later
* Rails 4.2.6 or later

# Installation
Add `toritsugi` to your Gemfile

```ruby
gem 'toritsugi', '~> 0.0.1'
```

Then install the migration files by running:

```bash
$ rake toritsugi:install:migrations
```

And apply them to your database.

```bash
$ rake db:migrate
```

Toritsugi is implemented as an Rails Engine. You can mount it anywhere you like this:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  mount Toritsugi::Engine => "/toritsugi"  # /toritsugi/xxxxxx will be the redirection path
end
```

# Usage
## Defining the redirection rules
The redirection rules will be stored in `toritsugi_rules` table. A rule is a set of following parameters:

Example:

```ruby
# Define a rule...
Toritsugi::Rule.new(source: "go-to-google", destination: "https://www.google.co.jp/").save

# ... to create this redirection
# GET /toritsugi/go-to-google => GET https://www.google.co.jp/
```

You can set these 3 attributes to each redirection rule.

* source
* destination
* active

### `source`
Set a unique key to determine which rule should be use to redirect the request.
Only word characters and hypens\(`[^a-zA-Z0-9_\-]`) are allowed and at least 5 characters needed.

```
/mount_point/:source
```

### `destination`
Set the desination url.

* You can omit `http://` scheme.
* Only `http` and `https` schemes are allowed.
* Urls begin with `/` will be assumed as a same-origin path.

### `active`
Set `false` to ignore the rule.

## Customization
You can customize the behavour of the gem through the initializer script

```bash
$ rails g toritsugi:initializer
# => config/initializers/toritsugi.rb
```

### Fallback path
You can set the fallback path to redirect to in case the given source url is not found on the rules table.

```ruby
Toritsugi.configure do |config|
  config.fall_back_path = '/sorry.html'  # default: '/'
end
```

### Insert custom logic on redirection
You can insert custom behaviour by setting a block as a `after_redirection_callback`.
The block will be called after each redirection with `request`, `parameters` and `rule`. The rule will be `nil` when the appropriate rule is not found.

```ruby
Toritsugi.configure do |config|
  config.after_refirection_callback = do |request, parameters, rule|
    # add custom behaviour here, such as logging, overwriting the rule, etc...
  end
end
```
