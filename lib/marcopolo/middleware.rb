module Marcopolo
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)

      req_headers = env.select {|k,v| k.start_with? 'HTTP_'}
        .collect {|pair| [pair[0].sub(/^HTTP_/, '').split('_').map(&:titleize).join('-'), pair[1]]}
        .sort

      req_hash = {
        "REQUEST" => "",
        "Remote Address" => req.ip,
        "Request URL" => req.url,
        "Request Method" => req.request_method,
        "REQUEST HEADERS" => ""
      }

      req_headers.to_a.each {|i| req_hash["\t" + i.first] = i.last }

      req_hash.merge!({
        "Request Body" => req.body.gets
      })

      Marcopolo.log req_hash.to_a.map {|o| o.join(': ') }.join("\n") + "\n"

      status, headers, response = @app.call(env)

      resp_hash = {
        "RESPONSE" => "",
        "Response Status" => response.status,
        "Response Headers" => ""
      }

      response.headers.to_a.each {|i| resp_hash["\t" + i.first] = i.last }

      resp_hash.merge!({
        "Response Body" => response.body
      })

      Marcopolo.log resp_hash.to_a.map {|o| o.join(': ') }.join("\n") + "\n"

      return [status, headers, response]
    end
  end
end