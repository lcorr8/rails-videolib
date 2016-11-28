class VideoPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end
  
#  def index
#    if @record.flatiron = true
#      if @user.admin? || @user.flatiron_student?
#        true
#      else
#        false
#      end
#    else
#      true
#    end
#  end

  def show?
    if @record.flatiron == true
      if @user.admin? || @user.flatiron_student?
        true
      else
        false
      end
    else
      true
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  class Scope < Scope
    def resolve
      if user.general_student?
        scope.where(:flatiron => false)
      elsif user.admin? || user.flatiron_student?
        scope.all
      end
    end
  end

     
end