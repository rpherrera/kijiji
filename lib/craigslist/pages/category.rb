class Craigslist::Pages::Category < Navigator
  attr_reader :paging
  
  def initialize(uri:)
    super(uri: uri)
  end
  
  def ads
    page.search('li.result-row').map do |li|
      ad_uri = uri.dup
      ad_uri.query = nil
      begin
        ad_uri.path = li.search('a').first.attr('href')
        Craigslist::Pages::Ad.new(uri: ad_uri)
      rescue
      end
    end.compact
  end
end