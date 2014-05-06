module Marcopolo
  class Marco < Rails::Railtie
    initializer "marcopolo.configure_rails_initialization" do |app|
      app.middleware.insert_before Rack::Runtime, "Marcopolo::Middleware"
    end
  end
end