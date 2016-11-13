class SectionPolicy < ApplicationPolicy
  
  def index?
    @user.user? || @user.flatiron_student || @user.admin?
  end

  def show?
    @user.user? || @user.flatiron_student? || @user.admin?
  end

  def new?
    @user.user? || @user.flatiron_student? || @user.admin?
  end

  def create?
    @user.user? || @user.flatiron_student? || @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin? #or not record.private?
  end

  def destroy?
    user.admin?
  end


  class Scope < Scope
    def resolve
      if user.user?
        scope.where(:flatiron => false)
      else
        scope.all
      end
    end
  end 


end