#!/usr/bin/env ruby
# 
# Rainer, 2016-01-05

# mandatory orchard requirements
require 'rubygems'
require 'bundler/setup'
require 'erb'


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Dependencies
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
require 'sinatra'

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# CONSTANTS
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
if ENV["APPLICATION"]
	URL_ROOT ||= "http://#{ENV["APPLICATION"]}.#{ENV["DATA_CENTER"]}.orchard.apple.com"
else
	URL_ROOT ||= "http://#{ENV["SERVER_NAME"]}:#{ENV["SERVER_PORT"]}"
end

get '/?' do
	response = "Success"
	[200, { "Content-Type" => "text/html" }, [response]]

	# TODO: add an ERB and erb files as a response to get '/?'

end

get '/request/?' do
	[200, { "Content-Type" => "text/html" }, [request.inspect]]

end

post '/request/?' do
	[200, { "Content-Type" => "application/json" }, [request.env["rack.input"].read]]

end

get "/__health/?" do
	# Replies 200 to indicate it's healthy.
	# Doc: https://docs.orchard.apple.com/ApplicationHealthEndpoint

	[200, {"Content-Type" => "text/plain"}, ["OK"]]
end

not_found do
	[307, {"Location" => URL_ROOT}, ["404 - Rerouting to root"]]
end