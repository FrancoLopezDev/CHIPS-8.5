Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  get '/search', to: 'movies#search_tmdb'
  post '/add_movie', to: 'movies#add_movie'
  root to: redirect('/movies')
end
