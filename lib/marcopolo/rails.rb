module Marcopolo
  class Marco < Rails::Railtie
    initializer "marcopolo.configure_rails_initialization" do |app|
      app.middleware.insert_before ActionDispatch::ParamsParser, "Marcopolo::Middleware"
    end
  end
end