module Shop
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, File.expand_path('../../', __FILE__)
        set :public_root, -> { File.join(root, 'static') }
        set :static, true
        set :method_override, true
      end
    end
  end
end
