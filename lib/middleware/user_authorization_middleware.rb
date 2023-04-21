class UserAuthorizationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @request = Rack::Request.new env
    return unauthorized if !current_user.is_admin?

    @app.call(env)
  end

  private

  def current_user
    @request.env['warden'].user # current_user
  end

  def unauthorized
    status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized]
    html = ActionView::Base.empty.render(file: 'public/401.html')

    [status_code, {'Content-Type' => 'text/html'}, [html]]
  end
end
