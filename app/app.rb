class Ask < Padrino::Application
    register ScssInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Cache
    register Padrino::Contrib::AutoLocale

    enable :sessions
    enable :caching

    set :sessions,
        :secret       => 'megusta',
        :expire_after => 1.year
    set :mailer_defaults, :from => 'no-reply@yunohost.st'
    set :delivery_method, :sendmail
    set :show_exceptions, false
    set :locales, [:en, :fr]

    ##
    # Application configuration options
    #
    #   set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    #   set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    #   set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    #   set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    #   set :public_folder, "foo/bar" # Location for static assets (default root/public)
    #   set :reload, false            # Reload application files (default in development)
    #   set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
    #   set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
    #   disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    #   layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #
    #
    # You can customize caching store engines:
    #
    #   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    #   set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    #   set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    #   set :cache, Padrino::Cache::Store::Memory.new(50)
    #   set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    configure :development do
        disable :caching
        set :delivery_method, :test
        set :show_exceptions, true
    end

    error 404 do
        render 'errors/404'
    end

end
