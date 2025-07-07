class Admin::UsersController < Rubee::BaseController
  include Rubee::AuthTokenable

  # GET /login (login form page)
  def edit
    response_with
  end

  # POST /admin/users/login (login logic)
  def login
    Rubee::Logger.info(message: "Login attempt for user #{params[:email]}")
    if authentificate! # AuthTokenable method that init @token_header
      Rubee::Logger.info(message: "Successful login for user #{@authentificated_user.email}")
      response_with(type: :redirect, to: "/admin/sections", headers: @token_header)
    else
      @error = "Wrong email or password"
      response_with(render_view: "admin_users_edit")
    end
  end

  # POST /admin/users/logout (logout logic)
  def logout
    unauthentificate! # AuthTokenable method aimed to handle logout action.
    # Make sure @zeroed_token_header is paRssed within headers options
    response_with(type: :redirect, to: "/login", headers: @zeroed_token_header)
  end
end
