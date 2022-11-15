Rails.application.routes.draw do

  get 'merchants/:id/dashboard', to: 'merchants#show'
  patch '/merchants/:id', to: 'merchants#update'

  resources :merchants, except: [:update] do
    resources :items, except: [:update]
  end

  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  resources :merchants, except: [:update] do
    resources :invoices, except: [:update]
  end

  patch '/merchants/:merchant_id/invoices/:id', to: 'invoices#update'

  namespace :admin do
    resources :merchants, except: [:update]
  end

  namespace :admin do
    resources :invoices, except: [:update]
  end

  patch '/admin/invoices/:id', to: 'admin/invoices#update'

  resources :admin, only: [:index]

  patch '/admin/merchants/:id', to: 'admin/merchants#update'

  resources :merchants, except: [:update] do
    resources :bulk_discounts, except: [:update]
  end

  patch '/merchants/:merchant_id/bulk_discounts/:id', to: 'merchant_bulk_discounts#update'
end
