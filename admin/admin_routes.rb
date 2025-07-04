Rubee::Router.draw do |router|
  # Login page
  router.get('/login', to: 'users#edit', namespace: :admin)
  router.post('/admin/users/login', to: 'users#login', namespace: :admin)
  router.post('/admin/users/logout', to: 'users#logout', namespace: :admin)

  # Sections
  router.get('/admin/sections', to: 'sections#index',
             namespace: :admin, model: { name: 'section', attributes: [
               { name: :id, type: :primary },
               { name: :title, type: :string },
               { name: :description, type: :text },
             ] })

  # Documents
  router.get('/admin/documents', to: 'documents#index',
             namespace: :admin, model: { name: 'document', attributes: [
               { name: :id, type: :primary },
               { name: :title, type: :string },
               { name: :content, type: :text },
               { name: :admin_section_id, type: :foreign_key },
             ] })
end
