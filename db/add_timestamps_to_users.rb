class AddTimestampsToUsers
  def call
    return if User.dataset.columns.include?(:created) && User.dataset.columns.include?(:updated)

    Rubee::SequelObject::DB.alter_table(:users) do
      add_column(:created, DateTime)
      add_column(:updated, DateTime)
    end
  end
end
