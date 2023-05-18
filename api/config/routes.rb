Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  get "current_user", to: "current_user#show"
  resources :characters, only: %i[index create] do
    collection do
      get :total
    end
  end
end
