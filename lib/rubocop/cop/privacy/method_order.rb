module RuboCop
  module Cop
    module Privacy
      # This cop checks that a Ruby's methods are ordered correctly.
      class MethodOrder < Cop
        MESSAGE = '`%s` method out of order'.freeze

        def initialize(config = nil, options = nil)
          super
          @protected_opened = false
          @private_opened = false
        end

        def on_send(node)
          _receiver, method_name, *_args = *node

          case method_name
          when :private
            check_private(node)
          when :protected
            check_protected(node)
          when :public
            add_offense(node, node.source_range, 'Public access modifier should never be redeclared.')
          end
        end

        private def check_private(node)
          if @private_opened
            add_offense(node, node.source_range, 'Private access modifier should only be declared once.')
          end
          @private_opened = true
        end

        private def check_protected(node)
          if @protected_opened
            add_offense(node, node.source_range, 'Protected access modifier should only be declared once.')
          end
          @protected_opened = true

          return unless @private_opened
          add_offense(node, node.source_range, format(MESSAGE, 'protected'))
        end
      end
    end
  end
end
