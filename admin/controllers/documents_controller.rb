class Admin::DocumentsController < Rubee::BaseController
  include Rubee::AuthTokenable
  auth_methods :index, :new, :create, :edit, :update, :destroy, :show
  before :index, :new, :create, :edit, :update, :destroy, :show, :set_user

  # GET /admin/documents
  def index
    @documents = Admin::Document.all
    @columns = Admin::Document.dataset.columns.map do |column|
      if column.to_s == "admin_section_id"
        "section"
      else
        column
      end
    end
    response_with(object: { user: @authentificated_user })
  end

  def index_json
    section_id = params[:section_id]
    @documents = Admin::Document.where(admin_section_id: section_id)
    response_with(object: @documents, type: :json)
  end

  # GET /api/documents/search/{q}
  def search
    query = params[:query].to_s.strip
    if query.length < 3
      response_with(object: [], type: :json)
    else
      documents_by_title = Admin::Document
        .dataset
        .where(Sequel.ilike(:title, "%#{query}%"))
        .limit(3)
        .all

      documents_by_description = Admin::Document
        .dataset
        .where(Sequel.ilike(:description, "%#{query}%"))
        .limit(3)
        .all

      documents = (documents_by_title + documents_by_description).uniq

      response_with(object: documents, type: :json)
    end
  end

  # GET /admin/documents/new
  def new
    @sections = Admin::Section.all
    response_with
  end

  # GET /admin/documents/{id}
  def show
    @document = Admin::Document.find(params[:id])
    response_with
  end

  # GET /api/documents/{id}
  def show_json
    @document = Admin::Document.find(params[:id])
    response_with(object: @document, type: :json)
  end

  # POST /admin/documents
  def create
    @document = Admin::Document.new(params[:document])
    if @document.save
      response_with(type: :redirect, to: "/admin/documents")
    else
      response_with(render_view: "admin_documents_new")
    end
  end

  # PUT /admin/documents/{id}
  def update
    @document = Admin::Document.find(params[:id])
    if @document.assign_attributes(params[:document]) && @document.save
      response_with(type: :redirect, to: "/admin/documents")
    else
      response_with(render_view: "admin_documents_edit")
    end
  end

  # DELETE /admin/documents/{id}
  def destroy
    @document = Admin::Document.find(params[:id])
    @document.destroy
    response_with(type: :redirect, to: "/admin/documents")
  end

  # GET /admin/documents/{id}/edit
  def edit
    @sections = Admin::Section.all
    @document = Admin::Document.find(params[:id])
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
