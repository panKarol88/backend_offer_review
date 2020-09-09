Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :offers, only: [:create] do
        member do
          patch '/accept', to: 'offers#accept'
          patch '/reject', to: 'offers#reject'
        end
      end
    end
  end
end
