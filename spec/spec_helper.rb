require 'fakeweb'
require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  london_search_page = File.read("./spec/fixtures/GoogleMoviesLondonSearch.html")
  FakeWeb.register_uri(:get,
                        "http://www.google.com/movies?near=London",
                        body: london_search_page,
                        content_type: "text/html")

end
