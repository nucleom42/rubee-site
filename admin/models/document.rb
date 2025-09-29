class Admin::Document < Rubee::SequelObject
  attr_accessor :id, :title, :content, :admin_section_id, :created, :updated

  holds :section, fk_name: :admin_section_id, namespace: :admin
end
