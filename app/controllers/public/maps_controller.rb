class Public::MapsController < ApplicationController
  require 'net/http'
  require 'json'

  def show
  end

  def search
    api_key = ENV['YOLP_API_KEY']
    query = params[:query]
    url = URI("https://map.yahooapis.jp/search/local/V1/localSearch?appid=#{api_key}&query=#{query}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)

    @results = JSON.parse(response.body)
  end
end
