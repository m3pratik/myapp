Rails.application.routes.draw do
  
  root 'login#index'
  post '/chat' => 'login#login_step'

  get '/channel' => 'chat#index'
  post '/send_message' => 'chat#send_message'
  get '/leave_chatroom' => 'chat#unsubscribe'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
