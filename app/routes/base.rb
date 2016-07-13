module Shop
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, File.expand_path('../../', __FILE__)
      end
    end
  end
end
