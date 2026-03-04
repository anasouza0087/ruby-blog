source "https://rubygems.org"

# Rails
gem "rails", "~> 8.1.1"

# Banco de dados
gem "pg" # Produção (Render)

# Use sqlite apenas em desenvolvimento
gem "sqlite3", ">= 2.1", group: :development

# Servidor web
gem "puma", ">= 5.0"

# Asset pipeline
gem "propshaft"

# Hotwire
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# JSON builder
gem "jbuilder"

# CORS
gem "rack-cors"

# Timezone Windows
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Performance
gem "bootsnap", require: false

# Deploy (opcional)
gem "kamal", require: false
gem "thruster", require: false

# Active Storage image processing
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem "rswag-api"
  gem "rswag-ui"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
