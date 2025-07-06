class CreateAdminSections
  def call
    return if Rubee::SequelObject::DB.tables.include?(:admin_sections)

    Rubee::SequelObject::DB.create_table(:admin_sections) do
      primary_key :id
			String :title
			String :description, text: true
    end
  end
end
