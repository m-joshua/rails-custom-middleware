Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('vendor')

Rails.application.config.assets.precompile << 'graphiql/rails/application.js'
Rails.application.config.assets.precompile << 'graphiql/rails/application.css'
