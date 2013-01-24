class SiteController < ApplicationController

  get '/'  do
    render text: 'welcome'
  end

  get '/posts/:post_id/comments/:comment_id'

  get '/some-page', as: 'page'

  get '/users/:user_id/edit', action: 'edit'

  get :terms_of_use, :contact, :about_us

  get '/another-page', '/randon-page'

  get '/different-page', :hidden_page

  post '/post-action'

  put '/put-action'

  delete '/delete-action'

  match '/match-action'

end
