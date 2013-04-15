require 'eventbrite-client'
require File.expand_path("../../auth_info.rb", __FILE__)

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '5m', :first_in => 0 do |job|
  @eb_client = EventbriteClient.new(EVENTBRITE[:auth_tokens])
  response = @eb_client.event_list_attendees({id: EVENTBRITE[:event_id]})
  send_event('attendees', {current: response["attendees"].length})

end
