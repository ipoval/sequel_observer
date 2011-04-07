PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  # configure test/unit assertions with rspec
  conf.expect_with :rspec, :stdlib

  # mock with
  conf.mock_with :rspec

  # inclusion filters - you can restrict which examples are run
  conf.filter_run :focus => true

  # exclusion filter
  conf.filter_run_excluding :broken => true
  conf.run_all_when_everything_filtered = true

  # Use the fail_fast option to tell RSpec to abort the run on first failure
  conf.fail_fast = true
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  BadgeService.tap { |app|  }
end