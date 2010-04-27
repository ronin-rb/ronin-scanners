require 'ronin/database'
require 'ronin/int'

require 'spec_helper'

module Helpers
  Database.repositories[:default] = 'sqlite3::memory:'

  Database.setup
end
