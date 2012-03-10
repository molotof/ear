$:.unshift(File.dirname(__FILE__))

require '../../../config/environment'
require 'test/unit'

class TestYfrogScraper < Test::Unit::TestCase

  def test_twitpic_search_jcran
    x = Ear::Client::Yfrog::YfrogScraper.new
    results = x.search_by_user "jcran"
    
    #assert results.count == 20, "Expected 20 results, got #{results.count}"
    #results.each do |result|
    #  assert result.remote_path =~ /cloudfront/
    #end

  end

end
