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
    u = User.where(:email => params[:email]).first

    if(!u.nil?)

      HipparidakoMailer.recommendation_email(u).deliver
      flash[:notice] = "Thank you! Your recommendations have been delivered!"

    else 

      u = User.new(:email => params[:email], :genres => JSON.parse(params[:genres]))
      if u.valid? and u.save
        HipparidakoMailer.recommendation_email(u).deliver
        flash[:notice] = "Thank you! Your recommendations have been delivered!"
      else
        flash[:notice] = u.errors.messages.first
      end

    end
    redirect_to '/books'
  end
end
