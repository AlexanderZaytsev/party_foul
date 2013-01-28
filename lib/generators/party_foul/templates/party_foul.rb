PartyFoul.configure do |config|
  # the collection of exceptions to be ignored by PartyFoul
  # The constants here *must* be represented as strings
  config.ignored_exceptions    = ['ActiveRecord::RecordNotFound', 'ActionController::RoutingError']

  # The names of the HTTP headers to not report
  config.filtered_http_headers = ['Cookie']

  # The OAuth token for the account that is opening the issues on Github
  config.oauth_token           = '<%= @oauth_token %>'

  # The API endpoint for Github. Unless you are hosting a private
  # instance of Enterprise Github you do not need to include this
  config.endpoint              = '<%= @endpoint %>'

  # The Web URL for Github. Unless you are hosting a private
  # instance of Enterprise Github you do not need to include this
  config.web_url               = '<%= @web_url %>'

  # The organization or user that owns the target repository
  config.owner                 = '<%= @owner %>'

  # The repository for this application
  config.repo                  = '<%= @repo %>'

  # The branch for your deployed code
  # config.branch              = 'master'
end
