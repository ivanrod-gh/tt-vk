Rails.application.routes.draw do
  resources :students, only: %i[create destroy]

  resources :schools, only: [] do
    resources :classes, only: %i[index] do
      resources :students, only: %i[index]
    end
  end
end
