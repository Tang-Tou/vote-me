Rails.application.routes.draw do
  # 自動做出八條路徑七個action
  resources :candidates do
    # 可使用member(routes顯示id)跟collection(不會顯示id)新增路徑
    member do
      post :vote
    end
  end
  # post '/candidates/:id/vote', to: 'candidates#vote'
end
