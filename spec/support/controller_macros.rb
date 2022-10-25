module ControllerMacros
  def login_admin_user
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create(:admin_user)

      sign_in @user
    end
  end
end
