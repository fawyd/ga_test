module Reports
  class PageViews
    extend Garb::Model

    dimensions :keyword

    metrics :pageviews, :visits
  end

end
