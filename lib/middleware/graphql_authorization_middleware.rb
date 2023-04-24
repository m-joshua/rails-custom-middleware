class GraphqlAuthorizationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @request = ActionDispatch::Request.new(env)
    return respond_normal if !@request.path.start_with?("/graphql") # skip non-graphql routes
    return respond_normal if @request.params.blank?

    variables, operation_name = action_info
    policy = GraphqlPolicy.new(current_user, variables)
    return respond_normal if !policy.respond_to?(operation_name)
    return respond_unauthorized if !policy.public_send(operation_name)

    respond_normal
  end

  private

  def current_user
    @request.env['warden'].user(:user) # current_user
  end

  def action_info
    variables = @request.params[:variables] || {}
    operation_name = @request.params[:operationName]
    operation_name = operation_name.to_s.underscore + "?"
    [variables, operation_name]
  end

  def respond_normal
    @app.call(@request.env)
  end

  def respond_unauthorized
    status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized]
    data = {error: "Unauthorized!",
            extensions: { code: "UNAUTHORIZED" }}
    [status_code, {'Content-Type' => 'application/json'}, [data.to_json]]
  end
end
