Rails.application.routes.draw do
  root 'home#index'
  get 'home/popup'=>'home#popup'
  get 'home/no_aside'=>'home#no_aside'
  get 'feed',:to=>'home#feed'

  resources :intro, :blogs, :gallery_categories, :galleries, :notices, :faq_categories,:faqs, :histories, :questions, :guest_books

  get 'tags/:tag', to: 'tags#index', as: :tag
  resources :comments, only: [:create, :destroy]


  # Admin 인증 라우트
  devise_for :admins,
             class_name: 'User',
             path: 'admins',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             },
             controllers: {
               sessions: 'admins/sessions'
             }
  devise_for :users, :controllers => {:sessions => "users/sessions", :registrations => "users/registrations"}, :path_names => {:sign_up => 'new', :sign_in => 'login', :sign_out => 'logout'}

  devise_scope :user do
    get '/login', to: 'users/sessions#new', as: :login_redirect
    delete '/logout', to: 'users/sessions#destroy', as: :logout_redirect
  end

  namespace :admin do
    root to: 'home#index'

    resources :users
    resources :intro,:gallery_categories, :galleries, :faq_categories,:faqs, :blog_categories, :notices, :site, :intro, :contacts, :notices, :histories, :portfolios
    resources :questions do
      resources :question_comments
    end

    resources :blogs do
      resources :blog_comments
    end

    resources :questions do
      get 'password',:on=>:collection
      post 'password',:on=>:collection
      resources :question_comments
    end

    resources :guest_books do
      resources :guest_book_comments do
        get 'password',:on=>:collection
        post 'password',:on=>:collection
      end
    end
  end
end