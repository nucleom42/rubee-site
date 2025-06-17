class MainController < Rubee::BaseController
  def index
    response_with redirect: { to: '/main' }
  end
end
