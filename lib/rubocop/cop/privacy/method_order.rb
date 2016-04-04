module RuboCop
  module Cop
    module Privacy
      # This cop checks that a Ruby's methods are ordered correctly.
      class MethodOrder < Cop
        MESSAGE = '`%s` method out of order'.freeze
      end
    end
  end
end
