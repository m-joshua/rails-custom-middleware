class UserAuthenticator
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new env
    p request.env['warden'].user # <--- checkmate

    @app.call(env)
  end
end
