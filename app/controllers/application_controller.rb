class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :access_denied

  private

  def access_denied
    return render file: "#{Rails.root}/public/401.html",
                  layout: false, status: 401
  end
end
