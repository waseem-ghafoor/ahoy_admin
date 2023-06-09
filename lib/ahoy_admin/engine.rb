# frozen_string_literal: true

module AhoyAdmin
  class Engine < ::Rails::Engine
    isolate_namespace(AhoyAdmin)

    config.autoload_paths << "#{config.root}/app/presenters"

    initializer("ahoy_admin.assets.precompile") do |app|
      app.config.assets.precompile << "ahoy_admin_manifest.js"
    end

    config.generators do |g|
      g.template_engine(:slim)
      g.assets(false)
      g.helper(true)
    end
  end

  Engine.config.tap do |config|
    config.brand_name = "Ahoy Admin"
    config.current_user_admin = ->(user) { user&.admin? || Rails.env.development? }
    config.current_user_method = :current_user
    config.domains = []
    config.head_favicon_url = "/favicon.ico"
    config.head_meta_description = "Ahoy Admin Panel"
    config.head_meta_keywords = "ahoy, admin, panel, analytics"
    config.head_meta_noindex = false # true will hide meta-description and meta-keywords tags
    config.head_title = "Ahoy Admin"
    config.time_zone = "UTC"
    config.widgets = %w[
      views_by_page
      visits_by_bot
      visits_by_country
      visits_by_device
      visits_by_referrer
    ]
  end

  class << self
    def configure
      yield Engine.config
    end
  end
end
