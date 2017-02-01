class PartyFoul::EnvDump
  PARAMS = %w(REQUEST_URI REQUEST_METHOD HTTP_USER_AGENT HTTP_ACCEPT HTTP_ACCEPT_ENCODING HTTP_VERSION action_dispatch.parameter_filter action_dispatch.request.parameters)
  attr_accessor :data

  def initialize(env)
    @data = env.slice(*PARAMS)
    @data['action_controller.instance.class'] = env['action_controller.instance'].class

    parameter_filter = ActionDispatch::Http::ParameterFilter.new(env["action_dispatch.parameter_filter"])
    @data['action_dispatch.request.parameters'] = parameter_filter.filter(env['action_dispatch.request.parameters'] || {})
    @data['rack.session'] = parameter_filter.filter(env['rack.session'].to_hash || {})
  end

  def [](key)
    @data[key]
  end
end