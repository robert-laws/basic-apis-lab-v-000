class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
      @res = Faraday.get('https://developer.github.com/v3/search') do |req|
        req.params['q'] = params[:query] + '+user:dtrupenn'
      end

      body = JSON.parse(@res.body)
      if @res.success?
        @repos = body['items']
      else
        @error = body['message']
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout error."
    end

    render 'search'
  end
end
