class Admin::UserAdminsController < Rubee::BaseController
  include Rubee::AuthTokenable

  def edit
    response_with
  end

  def login
    if authentificate! # AuthTokenable method that init @token_header
      response_with(type: :redirect, to: "/documents", headers: @token_header)
    else
      @error = "Wrong email or password"
      response_with(render_view: "admin_user_admins_edit")
    end
  end

  def logout
    unauthentificate!

    response_with(type: :redirect, to: "/admin/login")
  end
end
