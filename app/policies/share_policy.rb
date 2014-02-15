class SharePolicy < ApplicationPolicy
  def index?
    true
  end

  def public?
    true
  end

  def header?
    true
  end

  def proxy_content?
    true
  end

  def show?
    belongs_to_user?
  end

  def create?
    belongs_to_user?
  end

  def update?
    belongs_to_user?
  end

  def destroy?
    belongs_to_user?
  end

  private

  def belongs_to_user?
    user && record.user_id == user.id
  end
end
