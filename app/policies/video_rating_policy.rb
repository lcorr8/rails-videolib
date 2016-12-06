class VideoRatingPolicy < ApplicationPolicy

  def show?
    
  end

  def index?
    #when should i use @record versus record? or @user vs user
    if record.first.user == user
      true
    else
      false 
    end
  end

  def new?
    user.admin? || user.flatiron_student? || user.general_student?
  end

  def create?
    user.admin? || user.flatiron_student? || user.general_student?
  end

  def edit?
    if record.user == user
      true
    else
      false 
    end
  end

  def update?
    if record.user == user
      true
    else
      false 
    end
  end

  def destroy?
    if record.user == user
      true
    else
      false 
    end
  end

end