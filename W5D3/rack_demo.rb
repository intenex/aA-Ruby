require 'rack'
require 'json'

class RackApplication
	def self.call(env)
		['200'], {'Content-Type' => 'text/html'}, ["Body of request"]] # this is what Rack requires back from every .call method call, an array with 1. the status of the HTTP request, 2, a hash of all the headers, and 3. the body of the HTTP response love it so simple
	end
end

class SimpleApp
	def self.call(env)
		req = Rack::Request.new(env) # this will build out a Ruby object of the entire environment hash passed in
		res = Rack::Response.new

		name = req.params['name'] # ah this is where params come from awesome has the query hash and the body of the request
		res.write("Hello #{name}") # note need double quotes for interpolation except in JS need the backtick lol `` # this will also automatically return the body size meta data thing
		res.finish # this will at any point will return the correct array that Rack needs
	end
end

class CookieApp
	def self.call(env)
		req = Rack::Request.new(env)
		res = Rack::Response.new

		food = req.params[:food]
		if food
			res.set_cookie( # this takes a name of the cookie and then a hash with the path of the domain where the cookie should be accessible and the actual value of the cookie love it
				'_my_cookie_app', # the name of the cookie
				{
					path: '/', # this cookie is available anywhere from the root and below
					value: {food: food}.to_json # the value of the cookie, there's no way to store a Ruby hash in a cookie so have to serialize it into json so you can parse it back on the other side
				}) # amazing there's just a set_cookie method to use great learm all the methods for sure
			req.write("Your favorite food has been set to #{food}")
		else
			cookie = req.cookies['_my_cookie_app']
			cookie_val = JSON.parse(cookie)
			food = cookie_val['food']
			req.write("Your favorite food is #{food}")
		end

		res.finish
	end
end

app = Proc.new do |env| # doesn't have to be a class we pass in, can be anything, omg you can just use the Proc object since they natively respond to Proc.call already and return just whatever is the result of the block of the Proc amazing lol
	req = Rack::Request.new(env)
	res = Rack::Response.new

	if req.path.start_with?("/redirect_to_example")
		res.status = 302
		res['Location'] = 'http://example.com' # the bracket method is the convenience method for setting headers on Rack::Response objects
	else
		res.write("Nothing to see here")
	end

	res.finish

	# a redirect is just a 302 status code + a header called location to tell the browser where to go
end

# amazing that this is so straightforward nothing is magical fucking love it
Rack::Server.start({
	app: app, # Rack will call the RackApplication.call method every time a request comes through and pass in all the HTTP request details in the env argument variable
	Port: 3000
})