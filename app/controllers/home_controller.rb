class HomeController < ApplicationController

  before_filter :set_ouath

  def index
    if @authorized
      @profiles = Garb::Management::Profile.all(@garbsession)
      gen_report if params[:profile].present?
    end
  end

  private

  def gen_report
    @profile = Garb::Management::Profile.all(@garbsession).first
    start_date = Date.today - 15
    if params[:start_date].present?
      d = params[:start_date]
      start_date = Date.new(d['(1i)'].to_i, d['(2i)'].to_i, d['(3i)'].to_i)
    end
    @report = Reports::PageViews.results(@profile,
                                         start_date: start_date,
                                         end_date: Date.today,
                                         limit: 50)
  end

  def set_ouath
    if session[:google_token] and session[:google_secret]
      consumer = OAuth::Consumer.new(GOOGLE_KEY, GOOGLE_SECRET, {
        :site => 'https://www.google.com',
        :request_token_path => '/accounts/OAuthGetRequestToken',
        :access_token_path => '/accounts/OAuthGetAccessToken',
        :authorize_path => '/accounts/OAuthAuthorizeToken'
      })
      @garbsession = Garb::Session.new
      @garbsession.access_token = OAuth::AccessToken.new(consumer, session[:google_token], session[:google_secret])
      @authorized = true
    end
  end
end
