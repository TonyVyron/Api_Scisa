Rails.application.routes.draw do
  resources :categorias do
    resources :productos
  end

  resources :productos
end