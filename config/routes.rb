Headshare::Application.routes.draw do
  devise_for :users
  resources :shares do
    get 'public', on: :collection
  end

  get '/:id', controller: 'shares', action: 'public', constraints: { id: /\d+/ }
  root "shares#index"
end
