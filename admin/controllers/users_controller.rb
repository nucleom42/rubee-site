class Admin::UsersController < Rubee::BaseController
  include Rubee::AuthTokenable

  REDIRECT_URI = 'https://rubee.dedyn.io/admin/users/outh_callback'
  CLIENT_ID = ENV['GOOGLE_CLIENT_ID']
  CLIENT_SECRET = ENV['GOOGLE_CLIENT_SECRET'] || "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"

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

  # GET /admin/users/outh_login
  def outh_login
    response_with(
      type: :redirect,
      to: auth_client.auth_code.authorize_url(
        redirect_uri: REDIRECT_URI,
        scope: 'email profile openid'
      )
    )
  end

  # GET /admin/users/outh_callback
  def outh_callback
    code = params[:code]
    token = auth_client.auth_code.get_token(code, redirect_uri: REDIRECT_URI)
    user_info = JSON.parse(token.get('https://www.googleapis.com/oauth2/v1/userinfo?alt=json').body)
    Rubee::Logger.debug(object: user_info, method: "outh_callback", class: "UsersController")

    user = User.where(email: user_info['email'])&.last
    unless user
      raise "User with email #{user_info['email']} not found"
    end

    params[:email] = user_info['email']
    params[:password] = user.password

    if authentificate! # AuthTokenable method that init @token_header
      Rubee::Logger.info(message: "Successful Outh login for user #{@authentificated_user.email}")
      response_with(type: :redirect, to: "/admin/sections", headers: @token_header)
    else
      @error = "Something went wrong"
      response_with(render_view: "admin_users_edit")
    end
  rescue OAuth2::Error => e
    @error = "OAuth login failed"
    response_with(render_view: "admin_users_edit")
  rescue StandardError => e
    @error = "Something went wrong"
    response_with(render_view: "admin_users_edit")
  end

  # POST /admin/users/logout (logout logic)
  def logout
    unauthentificate! # AuthTokenable method aimed to handle logout action.
    # Make sure @zeroed_token_header is paRssed within headers options
    response_with(type: :redirect, to: "/login", headers: @zeroed_token_header)
  end

  private

  def auth_client
    @client ||= OAuth2::Client.new(
      CLIENT_ID,
      CLIENT_SECRET,
      site: 'https://accounts.google.com',
      authorize_url: '/o/oauth2/auth',
      token_url: 'https://oauth2.googleapis.com/token'
    )
  end
end
