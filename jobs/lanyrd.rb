require 'lanyrd'
require File.expand_path("../../auth_info.rb", __FILE__)

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '30m', :first_in => 0 do |job|
  @lanyrd  = Lanyrd::Client.new
  speakers = @lanyrd.speakers(LANYRD[:name])
  names = []
  speakers.each {|s| names << {label: s["title"], value: ""}}
  send_event('speakers', {items: names})
end
