require 'rubygems'

module RuboCop
  module Privacy
    module Version
      STRING = '0.1.0'

      def self.gem_version
        Gem::Version.new(STRING)
      end
    end
  end
end
