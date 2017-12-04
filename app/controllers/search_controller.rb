class SearchController < ApplicationController
  def index

    query = params[:q]
    like_query = "%#{query}%"

    @search_query = query
    @search_results = Car.
      joins(:model => :brand).
      where(
        "brands.name LIKE :lq OR models.name LIKE :lq OR cars.year = :q OR cars.color LIKE :lq",
        lq: like_query,
        q: query
      ).
      more_important_first

  end
end
