module Marcopolo
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)

      allow = Marcopolo.allow(@request)

      if allow
        rawlog_request(env)
      else
        Marcopolo.log "Filtering request: #{@request.request_method} #{@request.url}"
      end

      status, headers, response = @app.call(env)

      rawlog_response(status, headers, response) if allow

      return [status, headers, response]
    end

    def rawlog_request(env)
      req_headers = env.select {|k,v| k.start_with? 'HTTP_'}
        .collect {|pair| [pair[0].sub(/^HTTP_/, '').split('_').map(&:titleize).join('-'), pair[1]]}
        .sort

      req_hash = {
        "REQUEST" => "",
        "Remote Address" => @request.ip,
        "Request URL" => @request.url,
        "Request Method" => @request.request_method,
        "REQUEST HEADERS" => ""
      }

      req_headers.to_a.each {|i| req_hash["\t" + i.first] = i.last }

      req_hash.merge!({
        "Request Body" => @request.body.string
      })

      Marcopolo.log req_hash.to_a.map {|o| o.join(': ') }.join("\n") + "\n"
    rescue => e
      Marcopolo.log "Failed to log request: #{e}"
    end

    def rawlog_response(status, headers, response)
      resp_hash = {
        "RESPONSE" => "",
        "Response Status" => status,
        "Response Headers" => ""
      }

      headers.to_a.each {|i| resp_hash["\t" + i.first] = i.last }

      response_body = response.respond_to?(:body) ? response.body : response

      resp_hash.merge!({
        "Response Body" => response_body
      })

      Marcopolo.log resp_hash.to_a.map {|o| o.join(': ') }.join("\n") + "\n"
    rescue => e
      Marcopolo.log "Failed to log response: #{e}"
    end
  end
end