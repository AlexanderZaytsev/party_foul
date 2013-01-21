require 'test_helper'

describe 'Party Foul Confg' do
  it 'sets the proper config variables' do
    PartyFoul.config do |config|
      config.oauth_token = 'test_token'
      config.endpoint    = 'test_endpoint'
      config.owner       = 'test_owner'
      config.repo        = 'test_repo'
    end

    PartyFoul.github.must_be_instance_of Github::Client
    PartyFoul.github.oauth_token.must_equal 'test_token'
    PartyFoul.github.endpoint.must_equal 'test_endpoint'
    PartyFoul.owner.must_equal 'test_owner'
    PartyFoul.repo.must_equal 'test_repo'
  end
end
