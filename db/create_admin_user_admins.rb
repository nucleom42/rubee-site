class CreateAdminUserAdmins
  def call
    return if Rubee::SequelObject::DB.tables.include?(:admin_user_admins)

    Rubee::SequelObject::DB.create_table(:admin_user_admins) do
      primary_key :id
			String :email
			String :password
    end
  end
end
