class CreateAdminDocuments
  def call
    return if Rubee::SequelObject::DB.tables.include?(:admin_documents)

    Rubee::SequelObject::DB.create_table(:admin_documents) do
      primary_key :id
			String :title
			String :content, text: true
			foreign_key :admin_section_id, :admin_sections
    end
  end
end
