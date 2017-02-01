require 'party_foul/processors/base'

class PartyFoul::Processors::Sidekiq < PartyFoul::Processors::Base
  include Sidekiq::Worker
  sidekiq_options queue: 'party_foul'

  # Passes the exception and rack env data to Sidekiq to be processed later
  #
  # @param [Exception, Hash]
  def self.handle(exception, env)
    perform_async(Marshal.dump(exception).force_encoding('ISO-8859-1').encode('UTF-8'), Marshal.dump(env).force_encoding('ISO-8859-1').encode('UTF-8'))
  end

  def perform(exception, env)
    PartyFoul::ExceptionHandler.new(Marshal.load(exception.force_encoding('UTF-8').encode('ISO-8859-1')), Marshal.load(env.force_encoding('UTF-8').encode('ISO-8859-1'))).run
  end
end
