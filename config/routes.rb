Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :students, only: %i[create destroy]

      resources :schools, only: [] do
        resources :klasses, only: %i[index], shallow: true do
          resources :students, only: %i[index]
        end
      end
    end
  end
end
