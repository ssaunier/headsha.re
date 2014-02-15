Headshare::Application.routes.draw do
  devise_for :users
  resources :shares do
    get 'public', on: :collection
    get 'header', on: :member
    get 'proxy_content', on: :member
  end

  get '/:id', controller: 'shares', action: 'public', constraints: { id: /\d+/ }
  root "home#index"
end
