class BracketLogger < Logger
  attr_accessor :request

  def format_message(severity, timestamp, progname, msg)
    if request && request.uuid
      "[#{request.uuid}] #{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
    end
  end
end

logfile = File.open("#{Rails.root}/log/bracket.log", "a")
logfile.sync = true
BRACKET_LOG = BracketLogger.new(logfile)
