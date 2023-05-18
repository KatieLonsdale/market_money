# SimpleCov
require 'simplecov'
SimpleCov.start

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # FactoryBot
  config.include FactoryBot::Syntax::Methods

  # ShouldaMatchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end

def mock_atm
  {
            "type": "POI",
            "id": "B5kJ7Zov0IZyyAmdPOvIvQ",
            "score": 8.7394101607,
            "dist": 2748.404939,
            "info": "search:ta:840359000381920-US",
            "poi": {
                "name": "Cardtronics",
                "brands": [
                    {
                        "name": "Cardtronics"
                    }
                ],
                "categorySet": [
                    {
                        "id": 7397
                    }
                ],
                "categories": [
                    "cash dispenser"
                ],
                "classifications": [
                    {
                        "code": "CASH_DISPENSER",
                        "names": [
                            {
                                "nameLocale": "en-US",
                                "name": "cash dispenser"
                            }
                        ]
                    }
                ]
            },
            "address": {
                "streetNumber": "820",
                "streetName": "Route 66",
                "municipality": "Moriarty",
                "countrySecondarySubdivision": "Torrance",
                "countrySubdivision": "NM",
                "countrySubdivisionName": "New Mexico",
                "postalCode": "87035",
                "countryCode": "US",
                "country": "United States",
                "countryCodeISO3": "USA",
                "freeformAddress": "820 Route 66, Moriarty, NM 87035",
                "localName": "Moriarty"
            },
            "position": {
                "lat": 35.004683,
                "lon": -106.029628
            },
            "viewport": {
                "topLeftPoint": {
                    "lat": 35.00558,
                    "lon": -106.03073
                },
                "btmRightPoint": {
                    "lat": 35.00378,
                    "lon": -106.02853
                }
            },
            "entryPoints": [
                {
                    "type": "main",
                    "position": {
                        "lat": 35.00477,
                        "lon": -106.02936
                    }
                }
            ]
        }
end