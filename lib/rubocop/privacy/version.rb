require 'rubygems'

module RuboCop
  module Privacy
    # Version information for RuboCop Privacy
    module Version
      STRING = '0.2.0'.freeze

      def self.gem_version
        Gem::Version.new(STRING)
      end
    end
  end
end
