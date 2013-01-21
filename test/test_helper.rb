if defined?(M)
  require 'minitest/spec'
else
  require 'minitest/autorun'
end
require 'rack/test'
require 'mocha/setup'
require 'bourne'
require 'debugger'
require 'party_foul'

class MiniTest::Spec
  class << self
    alias :context :describe
  end
end

module MiniTest::Expectations
  infect_an_assertion :assert_received, :must_have_received
end
