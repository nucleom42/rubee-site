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
  router.get('/admin/sections/new', to: 'sections#new', namespace: :admin)
  router.post('/admin/sections', to: 'sections#create', namespace: :admin)
  router.get('/admin/sections/{id}', to: 'sections#show', namespace: :admin)
  router.get('/admin/sections/{id}/edit', to: 'sections#edit', namespace: :admin)
  router.put('/admin/sections/{id}', to: 'sections#update', namespace: :admin)
  router.delete('/admin/sections/{id}', to: 'sections#destroy', namespace: :admin)

  # Documents
  router.get('/admin/documents', to: 'documents#index',
             namespace: :admin, model: { name: 'document', attributes: [
               { name: :id, type: :primary },
               { name: :title, type: :string },
               { name: :content, type: :text },
               { name: :admin_section_id, type: :foreign_key },
             ] })
end
