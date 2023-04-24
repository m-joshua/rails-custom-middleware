class ActiveAdminAuthorizationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @request = ActionDispatch::Request.new(env)
    return respond_normal if !@request.path.start_with?("/admin") # skip non-admin routes

    params = setup_params
    controller = params[:controller].split("/").map(&:camelize).join("::")
    action = "#{params[:action]}?"

    policy = "#{controller}Policy"
    return respond_normal if !Object.const_defined?(policy)

    policy = policy.constantize.new(current_user, params)
    return respond_normal if !policy.respond_to?(action)
    return respond_unauthorized if !policy.public_send(action)

    respond_normal
  end

  private

  def current_user
    @request.env['warden'].user(:admin_user) # current_admin_user
  end

  def setup_params
    # merge path parameters and query parameters
    # @request.params only contains query params ?param1=value1
    # we can get path params at @route which is initialized at action_info method
    route = Rails.application.routes.recognize_path(@request.path, method: @request.request_method)
    route.merge(@request.params)
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
