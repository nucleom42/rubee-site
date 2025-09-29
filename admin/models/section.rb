class Admin::Section < Rubee::SequelObject
  attr_accessor :id, :title, :description, :created, :updated

  owns_many :documents, fk_name: :admin_section_id, namespace: :admin
end
