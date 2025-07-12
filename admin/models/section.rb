class Admin::Section < Rubee::SequelObject
  attr_accessor :id, :title, :description

  owns_many :documents, fk_name: :admin_section_id, namespace: :admin
end
