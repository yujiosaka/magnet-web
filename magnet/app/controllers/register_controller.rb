class RegisterController < ApplicationController
  def index
    @genres = {
      development: '開発',
      design: 'デザイン',
      writing: 'ライティング',
      office: '事務'
    }

    @user = User.new
  end

  def register
    u = User.new(:email => params[:email], :genres => JSON.parse(params[:genres]))
    if u.valid? and u.save
      flash[:notice] = "Thank you!"
    else
      flash[:notice] = u.errors.messages.first
    end
    redirect_to action: :index
  end
end
