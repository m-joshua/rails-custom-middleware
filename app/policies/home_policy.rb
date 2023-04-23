class HomePolicy < ApplicationPolicy

  def about?
    @user.is_admin?
  end
end
