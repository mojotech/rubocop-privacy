module RuboCop
  module Cop
    module Privacy
      # This cop checks that a Ruby's methods are ordered correctly.
      class MethodOrder < Cop
        METHOD_MESSAGE = '`%s` method out of order.'.freeze
        MODIFIER_MESSAGE = '`%s` access modifier out of order.'.freeze
        DECLARE_ONCE_MESSAGE = '`%s` should only be declared once.'.freeze

        def_node_matcher :group_level_modifier, <<-PATTERN
          (send nil ${:public :protected :private})
        PATTERN

        def_node_matcher :inline_modifier, <<-PATTERN
          (send nil ${:public :protected :private} (def ...))
        PATTERN

        def_node_matcher :prefix_modifier, <<-PATTERN
          (send nil ${:public :protected :private} (sym ...))
        PATTERN

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
          add_offense(node, node.source_range, format(DECLARE_ONCE_MESSAGE, 'Private')) if @private_opened
          @private_opened = true
        end

        private def check_protected(node)
          add_offense(node, node.source_range, format(DECLARE_ONCE_MESSAGE, 'Protected')) if @protected_opened
          @protected_opened = true

          return unless @private_opened
          if (visibility = group_level_modifier(node))
            add_offense(node, node.source_range, format(MODIFIER_MESSAGE, visibility))
          else
            visibility = inline_modifier(node) || prefix_modifier(node)
            add_offense(node, node.source_range, format(METHOD_MESSAGE, visibility))
          end
        end
      end
    end
  end
end
