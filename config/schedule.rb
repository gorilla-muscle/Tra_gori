require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/crontab.log"

every 1.day, at: '9:00 pm' do
  rake "send_line_notifies:notify"
end

# Learn more: http://github.com/javan/whenever
