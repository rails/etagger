module Etagger
  class Railtie < ::Rails::Railtie
    initializer 'install' do
      require 'etagger'

      ActiveSupport.on_load :action_controller do
        ActionController::Base.send :include, Etagger
      end
    end
  end
end
