module SpatialAdapter
  class Railtie < Rails::Railtie
    initializer "spatial_adapter.load_current_database_adapter" do
      # fix per http://mriddle.com/2012/11/22/Retrieving-DB-connection-from-Rails-App-on-Heroku.html
      adapter = Rails.configuration.database_configuration[Rails.env]['adapter']
      begin
        require "spatial_adapter/#{adapter}"
      rescue LoadError
        raise SpatialAdapter::NotCompatibleError.new("spatial_adapter does not currently support the #{adapter} database.")
      end
    end
  end
end

