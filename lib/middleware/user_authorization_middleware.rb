require 'pundit'

class UserAuthorizationMiddleware
  include Pundit::Authorization

  def initialize(app)
    @app = app
  end

  def call(env)
    @request = Rack::Request.new env
    controller, action = action_info
    policy = initialize_policy(controller)

    return respond_normal if !policy.respond_to?(action)
    return respond_unauthorized if !policy.public_send(action)

    respond_normal
  rescue NameError => e
    respond_normal
  end

  private

  def current_user
    @request.env['warden'].user # current_user
  end

  def action_info
    route = Rails.application.routes.recognize_path(@request.env["PATH_INFO"])
    [route[:controller], "#{route[:action]}?"]
  end

  def initialize_policy(controller)
    policy = "#{controller.camelize}Policy".constantize
    policy.new(current_user, nil)
  end

  def respond_normal
    @app.call(@request.env)
  end

  def respond_unauthorized
    status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized]
    html = ActionView::Base.empty.render(file: 'public/401.html')

    [status_code, {'Content-Type' => 'text/html'}, [html]]
  end
end
