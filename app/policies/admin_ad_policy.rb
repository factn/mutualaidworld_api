class AdminAdPolicy < Struct.new(:user, :admin_ad)
  def show?
    user.admin?
  end
end
