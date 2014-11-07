require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc
    config.encoding = "utf-8"

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en]
    config.i18n.default_locale = :en

    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
      g.assets false
      g.helper false
    end

    config.assets.precompile += %w( legacy/ie9.css )
    config.assets.precompile += %w( application_split2.css )

    Dir.glob("#{Rails.root}/vendor/assets/**/").each do |path|
      config.assets.paths << path
    end
    config.assets.precompile += %w( *.svg *.eot *.woff *.ttf )
    config.assets.precompile += %w( *.png *.jpg *.jpeg *.gif )
  end
end
