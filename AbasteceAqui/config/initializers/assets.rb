# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( smooth_scroll.js )
Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( jquery-confirm.js )
Rails.application.config.assets.precompile += %w( map_routes.js )
Rails.application.config.assets.precompile += %w( calculator.js )
Rails.application.config.assets.precompile += %w( highcharts-custom.js )
Rails.application.config.assets.precompile += %w( dinamic_selection.js )
Rails.application.config.assets.precompile += %w( county_anual.js.erb )
Rails.application.config.assets.precompile += %w( highcharts-custom.js )
Rails.application.config.assets.precompile += %w( county_rank.js )
Rails.application.config.assets.precompile += %w( data_table_options.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
