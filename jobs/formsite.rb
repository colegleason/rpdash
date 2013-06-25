require 'open-uri'
require 'rexml/document'

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '30m', :first_in => 0 do |job|
  result = URI.parse("#{FORMSITE[:jobfair_form]}results/count?fs_api_key=#{FORMSITE[:api_key]}").read
  doc = REXML::Document.new(result)
  companies = 0
  doc.root.elements.each('count') { |element| companies = element.get_text }

  result = URI.parse("#{FORMSITE[:startupfair_form]}results/count?fs_api_key=#{FORMSITE[:api_key]}").read
  doc = REXML::Document.new(result)
  startups = 0
  doc.root.elements.each('count') { |element| startups = element.get_text }

  send_event('companies', {current: companies })
  send_event('startups', {current: startups })
end
