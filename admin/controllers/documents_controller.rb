class Admin::DocumentsController < Rubee::BaseController
  include Rubee::AuthTokenable
  auth_methods :index

  def index
    response_with
  end
end
