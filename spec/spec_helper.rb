RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.expect_with :rspec, :stdlib
  conf.mock_with :rspec

  conf.filter_run :focus => true
  conf.filter_run_excluding :broken => true
  conf.run_all_when_everything_filtered = true

  conf.fail_fast = true
end
