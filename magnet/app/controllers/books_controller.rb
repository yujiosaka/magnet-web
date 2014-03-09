class BooksController < ApplicationController
  def index
    @key_phrases = KeyPhrase.where(:is_skill => true).order(:total_score.desc).limit(20)
    @trend_charts = TrendChart.where("image_url" => {"$exists" => true }).limit(10)
    #@trend_charts =  mongo_db()[:trend_charts].find({"image_url" => {"$exists" => true }}).limit(10)
    #puts @trend_charts.count
  end

  def view
    puts params[:category]
    puts mongo_db()[:books].find({}).limit(10).first
    render :text => params[:category]

  end

  def mongo_db
    mongo_options = HashWithIndifferentAccess.new(YAML.load_file("#{Rails.root}/config/mongoid.yml"))[Rails.env][:sessions]["default"]
    puts mongo_options
    conn = Moped::Session.new(mongo_options[:hosts])
    conn.use mongo_options[:database]
    if mongo_options[:username]
      conn.login(mongo_options[:username], mongo_options[:password])
      #conn.authenticate(mongo_options[:username], mongo_options[:password])
    end

    return conn
  end

end
