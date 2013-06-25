require 'dashing'
require File.expand_path("../auth_info.rb", __FILE__)

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
