module SpatialAdapter
  class Railtie < Rails::Railtie
    initializer "spatial_adapter.load_current_database_adapter" do
      begin
        adapter = ActiveRecord::Base.configurations[Rails.env]['adapter']
      rescue
        adapter = "mysql2"
      end
      begin
        require "spatial_adapter/#{adapter}"
      rescue LoadError
        raise SpatialAdapter::NotCompatibleError.new("spatial_adapter does not currently support the #{adapter} database.")
      end
    end
  end
end

