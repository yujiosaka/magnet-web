class HipparidakoMailer < ActionMailer::Base
  default from: "testmail.magnet@gmail.com"
     
  def recommendation_email(user)
    @user = user
    genre = user.genres[0]
    @trend_chart = TrendChart.where(:category => genre)
      .order(:year_month.desc).first

    @books = []
    
    puts @trend_chart[:words].to_s
    @trend_chart[:words].each do |word|
      puts word
      book = Book.where({:keyword => word})
                 .order(:year_month.desc)
                 .limit(1).first
      puts book
      @books.push book if !book.nil?
    end
    puts "===================================="
    puts @books.count

    mail(to: @user.email, subject: '[Magnet] 引っ張りだこレコメンデーション')
  end
end
