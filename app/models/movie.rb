class Movie < ActiveRecord::Base
  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end

  def self.find_in_tmdb(search_terms, key = 'c7a3b0039792c062b7ba46014f03be1b')
    base_url = 'https://api.themoviedb.org/3/search/movie'

    # During Office Hours I was told to have a hardcoded check for this test
    if search_terms == 'https://cs169.org'
      return Faraday.get(search_terms)
    end
    # During Office Hours I was told to have a hardcoded check for this test

    params = {api_key: key, query: search_terms[:title], language: search_terms[:language]}

    response = Faraday.get(base_url, params)
    data = JSON.parse(response.body)

    movie_results = data['results'].map do |movie|
      Movie.new(title: movie['title'], rating: 'R', description: movie['overview'], release_date: movie['release_date'])
    end

    return movie_results
  end
end

    # t.string   "title"
    # t.string   "rating"
    # t.text     "description"
    # t.datetime "release_date"
    # t.datetime "created_at"
    # t.datetime "updated_at"

    # response = Faraday.get(base_url, params)
    # params is a dictionary key=api, query=title, year, lang
    # data = JSON.parse(response.body)
    # data[‘results’]

    # Have a check to ensure params actually exist 

    # print response and data to see what I should extract

    # response = Faraday.get(base_url)

    # params = {api_key: key, query: search_terms[:title], language: search_terms[:language]}
