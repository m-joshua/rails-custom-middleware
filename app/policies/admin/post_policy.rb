class Admin::PostPolicy < ApplicationPolicy
  def edit?
    false # admin user do not have permission
  end
end
