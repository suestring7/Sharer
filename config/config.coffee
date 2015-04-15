path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'sharer'
    port: 3000
    db: 'mongodb://localhost/sharer-development'
    secret: 'DevelopmentSecret'

  test:
    root: rootPath
    app:
      name: 'sharer'
    port: 3000
    db: 'mongodb://localhost/sharer-test'
    secret: 'TestSecret'

  production:
    root: rootPath
    app:
      name: 'sharer'
    port: 3000
    db: 'mongodb://localhost/sharer-production'
    secret: 'ProductionSecret'

module.exports = config[env]
