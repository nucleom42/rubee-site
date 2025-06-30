STRUCTURE = {
  users: {
    id: {
      generated: false,
      allow_null: false,
      default: nil,
      db_type: "INTEGER",
      primary_key: true,
      auto_increment: true,
      type: "integer",
      ruby_default: nil
    },
    email: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    },
    password: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    }
  },
  admin__user_admins: {
    id: {
      generated: false,
      allow_null: false,
      default: nil,
      db_type: "INTEGER",
      primary_key: true,
      auto_increment: true,
      type: "integer",
      ruby_default: nil
    },
    email: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    },
    password: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    }
  },
  admin_sections: {
    id: {
      generated: false,
      allow_null: false,
      default: nil,
      db_type: "INTEGER",
      primary_key: true,
      auto_increment: true,
      type: "integer",
      ruby_default: nil
    },
    title: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    },
    description: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "TEXT",
      primary_key: false,
      type: "string",
      ruby_default: nil
    }
  },
  admin_user_admins: {
    id: {
      generated: false,
      allow_null: false,
      default: nil,
      db_type: "INTEGER",
      primary_key: true,
      auto_increment: true,
      type: "integer",
      ruby_default: nil
    },
    email: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    },
    password: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    }
  },
  admin_documents: {
    id: {
      generated: false,
      allow_null: false,
      default: nil,
      db_type: "INTEGER",
      primary_key: true,
      auto_increment: true,
      type: "integer",
      ruby_default: nil
    },
    title: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "varchar(255)",
      primary_key: false,
      type: "string",
      ruby_default: nil,
      max_length: 255
    },
    content: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "TEXT",
      primary_key: false,
      type: "string",
      ruby_default: nil
    },
    section_id: {
      generated: false,
      allow_null: true,
      default: nil,
      db_type: "INTEGER",
      primary_key: false,
      type: "integer",
      ruby_default: nil
    }
  }
}
