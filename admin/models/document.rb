class Admin::Document < Rubee::SequelObject
  attr_accessor :id, :title, :content, :section_id

  holds :admin_section
end
