RSpec.shared_context "api request authentication helper methods" do
  def sign_in(user)
    login_as(user, scope: :user)
  end

  def sign_out
    logout(:user)
  end
end
