# Katgut
Katgut is a Rails Engine for adding simple url redirection features to your apps.

The gem provides:
* Dynamic redirection rules on DB
* After redirection callbacks

# Requirements
* Ruby 2.3 or later
* Rails 4.2.6 or later

# Installation
Add `katgut` to your Gemfile

```ruby
gem 'katgut', '~> 0.0.1'
```

Then install the migration files by running:

```bash
$ rake katgut:install:migrations
```

And apply them to your database.

```bash
$ rake db:migrate
```

Katgut is implemented as an Rails Engine. You can mount it anywhere you like:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  mount Katgut::Engine => "/katgut"  # /katgut/xxxxxx will be the redirection path
end
```

# Usage
## Defining the redirection rules
The redirection rules will be stored in `katgut_rules` table. A rule is a set of following parameters:

* source
* destination
* active


### `source`
Set a unique key to determine which rule should be used to redirect the request.
Only word characters and hyphens\(`[^a-zA-Z0-9_\-]`) are allowed and at least 5 characters needed.
If you don't give any value for the `source` attribute, katgut generates a random value automatically.

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

## Example

```ruby
# Define a rule...
Katgut::Rule.new(source: "go-to-google", destination: "https://www.google.co.jp/").save

# ... to create this redirection
# GET /katgut/go-to-google => GET https://www.google.co.jp/
```

## URL helpers
Katgut defines url helpers to generate redirection urls.

Suppose the engine is mounted to your app in this way:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Katgut::Engine => "/katgut", as: 'katgut'
end
```

Then you can access predefined url helpers like this:

```ruby
# app/controllers/xxxx_controller.rb

katgut.rule_path("source_string")  # => "/katgut/source_string"
```

You can see all the predefined helpers in `Routes for Katgut::Engine` section in the list that `rake routes` generates.

```bash
$ rake routes | grep --ignore-case katgut

Routes for Katgut::Engine:
  rule GET  /:id(.:format) katgut/rules#show
```

## Customization
You can customize the behavour of the gem through the initializer script.

```bash
$ rails g katgut:initializer
# => config/initializers/katgut.rb
```

### Fallback path
You can set a alternative destination url for the case the given source url does not exist.

```ruby
Katgut.configure do |config|
  config.fall_back_path = '/not_found.html'  # default: '/'
end
```

### Custom codes after redirection
You can define a custom block that will be called after every redirection.
The block should have 3 argumets: `request`, `parameters` and `rule`.
The `rule` will be `nil` when the specified source url on the request was not valid.

```ruby
Katgut.configure do |config|
  config.after_refirection_callback = proc do |request, parameters, rule|
    # add custom behaviour here, such as logging, overwriting the rule, etc...
    # this block will be called in the context of Katgut::RulesController.
  end
end
```
