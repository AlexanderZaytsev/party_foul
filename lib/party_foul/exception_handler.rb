class PartyFoul::ExceptionHandler
  attr_accessor :exception, :env

  def self.handle(exception, env)
    handler = self.new(exception, env)
    handler.run
  end

  def initialize(exception, env)
    self.exception = exception
    self.env       = env
  end

  def run
    if issue = find_issue
      update_issue(issue)
    else
      create_issue
    end
  end

  def find_issue
    unless issue = PartyFoul.github.search.issues(owner: PartyFoul.owner, repo: PartyFoul.repo, state: 'open', keyword: fingerprint).issues.first
      issue = PartyFoul.github.search.issues(owner: PartyFoul.owner, repo: PartyFoul.repo, state: 'closed', keyword: fingerprint).issues.first
    end

    issue
  end

  def stack_trace
    exception.backtrace.map do |line|
      if matches = extract_file_name_and_line_number(line)
        " * [#{line}](../tree/master/#{matches[2]}#L#{matches[3]}) "
      else
        " * #{line} "
      end
    end.join("\n ")
  end

  def create_issue
    PartyFoul.github.issues.create(PartyFoul.owner, PartyFoul.repo, title: issue_title, body: issue_body, labels: ['bug'])
  end

  def update_issue(issue)
    params = {body: update_body(issue['body']), state: 'open'}

    if issue['state'] == 'closed'
      params[:labels] = ['bug', 'regression']
    end

    PartyFoul.github.issues.edit(PartyFoul.owner, PartyFoul.repo, issue['number'], params)
  end

  def issue_title
    line = exception.backtrace.select {|p| p =~ /#{app_root}/ }.first
    name_and_number = extract_file_name_and_line_number(line)[1]
    "#{exception} - #{name_and_number}"
  end

  def fingerprint
    Digest::SHA1.hexdigest(issue_title)
  end

  def update_body(body)
    begin
      current_count = body.match(/Count: `(\d+)`/)[1].to_i
      body.sub!("Count: `#{current_count}`", "Count: `#{current_count + 1}`")
      body.sub!(/Last Occurance: .+/, "Last Occurance: `#{Time.now}`")
      body
    rescue
      issue_body
    end
  end

  def params
    env['action_dispatch.request.path_parameters'] || env['QUERY_STRING']
  end

  def issue_body
    <<-BODY
Fingerprint: `#{fingerprint}`
Count: `1`
Last Occurance: `#{Time.now}`
Params: `#{params}`
Exception: `#{exception}`
Stack Trace:
```
#{stack_trace}
```
    BODY
  end

  private

  def app_root
    if defined?(Rails)
      Rails.root
    else
      Dir.pwd
    end
  end

  def file_and_line_regex
    /#{app_root}\/((.+?):(\d+))/
  end

  def extract_file_name_and_line_number(backtrace_line)
    backtrace_line.match(file_and_line_regex)
  end
end
