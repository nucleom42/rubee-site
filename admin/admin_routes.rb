Rubee::Router.draw do |router|
  router.get('/admin/login', to: 'user_admins#edit',
                             model: {
                               name: 'user_admin',
                               attributes: [
                                 { name: :id, type: :primary },
                                 { name: :email, type: :string },
                                 { name: :password, type: :string },
                               ],
                             },
                             namespace: :admin)
  router.get('/admin/sections', to: 'sections#index',
             namespace: :admin, model: { name: 'section', attributes: [
               { name: :id, type: :primary },
               { name: :title, type: :string },
               { name: :description, type: :text },
             ] })

  router.get('/admin/documents', to: 'documents#index',
             namespace: :admin, model: { name: 'document', attributes: [
               { name: :id, type: :primary },
               { name: :title, type: :string },
               { name: :content, type: :text },
               { name: :admin_section_id, type: :foreign_key },
             ] })
end
