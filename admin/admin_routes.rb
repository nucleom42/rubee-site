Rubee::Router.draw do |router|
  # Login page
  router.get('/login', to: 'users#edit', namespace: :admin)
  router.post('/admin/users/login', to: 'users#login', namespace: :admin)
  router.post('/admin/users/logout', to: 'users#logout', namespace: :admin)

  # Sections admin
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

  # Documents admin
  router.get('/admin/documents', to: 'documents#index',
             namespace: :admin, model: { name: 'document', attributes: [
               { name: :id, type: :primary },
               { name: :title, type: :string },
               { name: :content, type: :text },
               { name: :admin_section_id, type: :foreign_key },
             ] })

  router.get('/admin/documents/new', to: 'documents#new', namespace: :admin)
  router.post('/admin/documents', to: 'documents#create', namespace: :admin)
  router.get('/admin/documents/{id}', to: 'documents#show', namespace: :admin)
  router.get('/admin/documents/{id}/edit', to: 'documents#edit', namespace: :admin)
  router.put('/admin/documents/{id}', to: 'documents#update', namespace: :admin)
  router.delete('/admin/documents/{id}', to: 'documents#destroy', namespace: :admin)

  # Section API
  router.get('/api/sections', to: 'sections#index_json', namespace: :admin)

  # Document API
  router.get('/api/documents/{id}', to: 'documents#show_json', namespace: :admin)
  router.get('/api/sections/{section_id}/documents', to: 'documents#index_json', namespace: :admin)
end
