PartyFoul.configure do |config|
  # The collection of exceptions PartyFoul should not be allowed to handle
  # The constants here *must* be represented as strings
  config.blacklisted_exceptions = ['ActiveRecord::RecordNotFound', 'ActionController::RoutingError']

  # The OAuth token for the account that is opening the issues on GitHub
  config.oauth_token            = 'dcd6174b94c9a903ef2af035fbfe009619a85cdd'

  # The API endpoint for GitHub. Unless you are hosting a private
  # instance of Enterprise GitHub you do not need to include this
  config.endpoint               = 'https://api.github.com'

  # The Web URL for GitHub. Unless you are hosting a private
  # instance of Enterprise GitHub you do not need to include this
  config.web_url                = 'http://scvrush.com'

  # The organization or user that owns the target repository
  config.owner                  = 'darthdeus'

  # The repository for this application
  config.repo                   = 'scvrush'

  # The branch for your deployed code
  # config.branch               = 'master'

  # Additional labels to add to issues created
  # config.additional_labels    = ['production']
  # or
  config.additional_labels = Proc.new do |exception, env|
    labels = env["HTTP_HOST"] =~ /beta\./ ? ["beta"] : ["production"]
    labels << "database" if exception.message =~ /PG::Error/
    labels
  end

  # Limit the number of comments per issue
  # config.comment_limit        = 10
end
