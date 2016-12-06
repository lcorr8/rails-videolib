class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin?
  end

  def new?
    #only users can make themselves how do i handle that in terms of policies. 
    #or does devise already do this
  end

  def create?
    #only users can make themselves how do i handle that in terms of policies.
    #or does devise already do this
  end

  def show?
    @user.admin?
  end

  def edit?
    #only an admin can assign/remove flatiron status
  end

  def update?
    @user.admin? 
  end

  def destroy?
    if @user.admin? && @record != @user
      true
    else
      false
    end
    #admin can delete user's but can't delete their own account.
  end


end