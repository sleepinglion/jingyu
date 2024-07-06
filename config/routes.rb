Rails.application.routes.draw do
  root 'home#index'
  resources :comments, only: [:create, :destroy]

  devise_for :admins, :controllers => { :sessions => "admins/sessions",:registrations => "admins/registrations" }, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do
    get 'edit', :to => 'admins::Registrations#edit'
    get 'login', :to => 'admins::Sessions#new'
    get 'logout', :to=> 'admins::Sessions#destroy'
  end

  devise_for :users, :controllers => { :sessions => "users/sessions",:registrations => "users/registrations" }, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do
    get '/users', :to => 'users/registrations#index'
    get '/login', :to => 'users/sessions#new'
    get '/signup', :to => 'users/registrations#new'
  end

  resources :intro, :gallery_categories, :galleries, :notices, :faq_categories,:faqs, :histories

  resources :blogs do
    resources :blog_comments
  end

  resources :questions do
    get 'password',:on=>:collection
    post 'password',:on=>:collection
    resources :question_comments
  end

  resources :guest_books do
    get 'password',:on=>:collection
    post 'password',:on=>:collection
    resources :guest_book_comments do
      get 'password',:on=>:collection
      post 'password',:on=>:collection
    end
  end

  get 'home/popup'=>'home#popup'
  get 'home/no_aside'=>'home#no_aside'
  get 'feed',:to=>'home#feed'

  get 'blogs/:blog_id/blog_comments/:id/password',:to=>'blog_comments#password'
  post 'blogs/:blog_id/blog_comments/:id/password',:to=>'blog_comments#password'


  get 'guest_books/:guest_book_id/:id/password',:to=>'guest_books#password'
  post 'guest_books/:guest_book_id/:id/password',:to=>'guest_books#password'

  get 'guest_books/:guest_book_id/guest_book_comments/:id/password',:to=>'guest_book_comments#password'
  post 'guest_books/:guest_book_id/guest_book_comments/:id/password',:to=>'guest_book_comments#password'


  get 'tags/:tag', to: 'tags#index', as: :tag

  scope 'admin', module: 'admin', as: 'admin' do
    get '/' => 'admin_home#index'
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