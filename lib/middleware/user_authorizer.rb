class UserAuthorizer
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new env
    p request.env['warden'].user # current_user

    @app.call(env)
  end
end
