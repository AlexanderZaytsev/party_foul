# PartyFoul #

[![Build Status](https://secure.travis-ci.org/dockyard/party_foul.png?branch=master)](http://travis-ci.org/dockyard/party_foul)
[![Dependency Status](https://gemnasium.com/dockyard/party_foul.png?travis)](https://gemnasium.com/dockyard/party_foul)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/dockyard/party_foul)

Rails exceptions automatically opened as issues on Github

## Installation ##

In your Gemfile add the following:

```ruby
gem 'party_foul'
```

### Rails ###
If you are using Rails you can run the install generator.

```
rails g party_foul:install
```

This will prompt you for the Github credentials of the account that will
be opening the issues. The OAuth token for that account will be stored
in `config/initializers/party_foul.rb`. You may want to remove this and
store in an environment variable if you are not comfortable keeping this
token in version control.

### Other ###

You will need to initialize `PartyFoul`, you can use the following to do
so:

```ruby
PartyFoul.configure do |config|
  # the collection of exceptions to be ignored by PartyFoul
  config.ignored_exceptions = [ActiveRecord::RecordNotFound]

  # The OAuth token for the account that will be opening the issues on Github
  config.oauth_token        = 'abcdefgh1234567890'

  # The API endpoint for Github. Unless you are hosting a private
  # instance of Enterprise Github you do not need to include this
  config.endpoint           = 'https://api.github.com'

  # The organization or user that owns the target repository
  config.owner              = 'owner_name'

  # The repository for this application
  config.repo               = 'repo_name'
end
```

## Usage ##

Add as the very last middleware in your production `Rack` stack. For
example in Rails you would add the following to
`config/environments/production.rb`

```ruby
config.middleware.insert_before(-1, 'PartyFoul::Middleware')
```

You should create a Github account specific for opening issues if you
don't already have one. If you use your own account Github will not
notify you via email when a new issue is created with your credentials.

## Authors ##

[Brian Cardarella](http://twitter.com/bcardarella)

[Dan McClain](http://twitter.com/_danmcclain)

[We are very thankful for the many contributors](https://github.com/dockyard/party_foul/graphs/contributors)

## Versioning ##

This gem follows [Semantic Versioning](http://semver.org)

## Want to help? ##

Please do! We are always looking to improve this gem. Please see our
[Contribution Guidelines](https://github.com/dockyard/party_foul/blob/master/CONTRIBUTING.md)
on how to properly submit issues and pull requests.

## Legal ##

[DockYard](http://dockyard.com), LLC &copy; 2012

[@dockyard](http://twitter.com/dockyard)

[Licensed under the MIT license](http://www.opensource.org/licenses/mit-license.php)

