class AddTimestampsToAdminSections
  def call
    return if User.dataset.columns.include?(:created) && User.dataset.columns.include?(:updated)

    Rubee::SequelObject::DB.alter_table(:admin_sections) do
      add_column(:created, DateTime)
      add_column(:updated, DateTime)
    end
  end
end
