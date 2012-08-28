class HomeController < ApplicationController

  before_filter :set_oauth

  def index
    if @authorized
      begin
        @profiles = Garb::Management::Profile.all(@garbsession)

        start_date = Date.today - 15
        start_date = Date.parse(params[:date]) if params[:date].present?

        gen_report(start_date) if params[:profile].present?
      rescue Garb::DataRequest::ClientError => e
        @message = e.message
        render 'error'
      end
    end
  end

  private

  def gen_report(start_date)
    @profile = Garb::Management::Profile.all(@garbsession).detect {
      |profile| profile.web_property_id == params[:profile] }

      @report = Reports::PageViews.results(@profile,
                                           start_date: start_date,
                                           end_date: Date.today,
                                           limit: 50)
  end

  def set_oauth
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
