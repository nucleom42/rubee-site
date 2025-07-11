class Admin::SectionsController < Rubee::BaseController
  include Rubee::AuthTokenable
  auth_methods :index, :new, :create, :edit, :update, :destroy, :show
  before :index, :new, :create, :edit, :update, :destroy, :show, :set_user

  # GET /admin/sections
  def index
    @columns = Admin::Section.dataset.columns
    @sections = Admin::Section.all
    response_with(object: { user: @authentificated_user })
  end

  # GET /admin/sections/new
  def new
    response_with
  end

  # GET /admin/sections/{id}
  def show
    @section = Admin::Section.find(params[:id])
    response_with
  end

  # POST /admin/sections
  def create
    @section = Admin::Section.new(params[:section])
    if @section.save
      response_with(type: :redirect, to: "/admin/sections")
    else
      response_with(render_view: "admin_sections_new")
    end
  end

  # PUT /admin/sections/{id}
  def update
    @section = Admin::Section.find(params[:id])
    if @section.assign_attributes(params[:section]) && @section.save
      response_with(type: :redirect, to: "/admin/sections")
    else
      response_with(render_view: "admin_sections_edit")
    end
  end

  # DELETE /admin/sections/{id}
  def destroy
    @section = Admin::Section.find(params[:id])
    @section.destroy
    response_with(type: :redirect, to: "/admin/sections")
  end

  # GET /admin/sections/{id}/edit
  def edit
    @section = Admin::Section.find(params[:id])
    response_with
  end

  private

  def set_user
    @user = authentificated_user
  end

  def handle_auth
    if authentificated?
      yield
    else
      response_with(type: :redirect, to: "/login")
    end
  end
end
