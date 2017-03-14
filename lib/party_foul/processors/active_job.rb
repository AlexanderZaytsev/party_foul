class PartyFoul::Processors::ActiveJob < ApplicationJob
  queue_as 'party_foul'

  def self.handle(exception, env)
    set(wait: PartyFoul.handle_wait_time).perform_later(Marshal.dump(exception).force_encoding('ISO-8859-1').encode('UTF-8'), Marshal.dump(env).force_encoding('ISO-8859-1').encode('UTF-8'))
  end

  def perform(exception, env)
    PartyFoul::ExceptionHandler.new(Marshal.load(exception.force_encoding('UTF-8').encode('ISO-8859-1')), Marshal.load(env.force_encoding('UTF-8').encode('ISO-8859-1'))).run
  end
end
