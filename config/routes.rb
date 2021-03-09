Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :restaurants, except: [ :new, :edit ]
    end
  end
end


# YAY WE'RE DONE

# 1XX Informational, Still Processing
# 2XX A OK, success!
# 3XX Redirect
# 4XX You Fucked Up
# 5XX We Fucked UP (server)
