Headshare::Application.routes.draw do
  resources :shares do
    get 'public', on: :collection
  end

  get '/:id', controller: 'shares', action: 'public', constraints: { id: /\d+/ }
end
