require 'spec_helper'
require 'unirest'

describe "a capture attempt" do
  it "captures request logging" do
    stream = StringIO.new

    mock_headers = {
      "Header-Foo" => "value bar"
    }

    mock_params = {foo: :bar, blah: "dot com"}

    stub_request(:get, "http://localhost/?blah=dot%20com&foo=bar").
         with(:headers => {'Accept-Encoding'=>'gzip', 'Header-Foo'=>'value bar'}).
         to_return(:status => 200, :body => "", :headers => {})

    Marcopolo.capture stream do
      Unirest.get 'http://localhost', headers: mock_headers, parameters: mock_params
    end

    pending "actually test something"
    fail
  end
end