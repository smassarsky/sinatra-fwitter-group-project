class TweetsController < ApplicationController

  get '/tweets' do
    redirect "/login" if !Helpers.is_logged_in?(session)
    @user = User.find(session[:user_id])
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(user: User.find(session[:user_id]), content: params[:content])
    if tweet.errors.messages.empty?
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    redirect '/login' if !Helpers.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !Helpers.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if Helpers.current_user(session) != @tweet.user
    erb :'/tweets/edit'
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.update(content: params[:content])
      redirect "/tweets/#{params[:id]}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    redirect '/login' if !Helpers.is_logged_in?(session)
    tweet = Tweet.find(params[:id])
    tweet.destroy if Helpers.current_user(session) == tweet.user
    redirect '/tweets'
  end

end
