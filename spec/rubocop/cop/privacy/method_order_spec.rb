describe RuboCop::Cop::Privacy::MethodOrder do
  include SharedExamples

  subject(:cop) { described_class.new }

  context 'do not reopen public' do
    let(:source) do
      [
        'class Foo',
        '  def bar',
        '  end',
        '  public',
        '  def baz',
        '  end',
        'end'
      ]
    end
    let(:expected_offenses) do
      [{
        message: 'Public access modifier should never be redeclared.',
        severity: :convention,
        line: 4,
        column: 2,
        source: 'public'
      }]
    end
    include_examples 'reports offenses'
  end

  # TODO: based on config option of 'group'
  context 'only use access modifiers once per file when using "group" level configuration'

  context 'when no methods are out of order' do
    context 'with group level privacy' do
      let(:source) do
        <<-PRIVACY.undent
          class Foo
            def bar
            end

            protected

            def quack
            end

            private

            def quux
            end
          end
        PRIVACY
      end

      include_examples 'does not report any offenses'
    end

    context 'with postfix privacy' do
      let(:source) do
        <<-PRIVACY.undent
          class Foo
            def bar
            end

            def quack
            end
            protected :quack

            def quux
            end
            private :quux
          end
        PRIVACY
      end

      include_examples 'does not report any offenses'
    end

    context 'with inline privacy' do
      let(:source) do
        <<-PRIVACY.undent
          class Foo
            def bar
            end

            protected def quack
            end

            private def quux
            end
          end
        PRIVACY
      end

      include_examples 'does not report any offenses'
    end

    context 'with mixed-mode privacy' do
    end
  end

  context 'when one pair of methods is out of order' do
    context 'with group level privacy' do
      let(:source) do
        <<-PRIVACY.undent
          class Foo
            def bar
            end

            private

            def quux
            end

            protected

            def quack
            end
          end
        PRIVACY
      end
      let(:corrected_source) do
        <<-EOF.undent
          class Foo
            def bar
            end

            protected

            def quack
            end

            private

            def quux
            end
          end
        EOF
      end
      let(:expected_offenses) do
        [{
          message: '`protected` access modifier out of order.',
          severity: :convention,
          line: 10,
          column: 2,
          source: 'protected'
        }]
      end

      include_examples 'reports offenses'
      # include_examples 'autocorrects source'
    end

    context 'with postfix privacy' do
      let(:source) do
        <<-PRIVACY.undent
          class Foo
            def bar
            end

            def quux
            end
            private :quux

            def quack
            end
            protected :quack
          end
        PRIVACY
      end
      let(:corrected_source) do
        <<-EOF.undent
          class Foo
            def bar
            end

            def quack
            end
            protected :quack

            def quux
            end
            private :quux
          end
        EOF
      end
      let(:expected_offenses) do
        [{
          message: '`protected` method out of order.',
          severity: :convention,
          line: 11,
          column: 2,
          source: 'protected :quack'
        }]
      end

      include_examples 'reports offenses'
      # include_examples 'autocorrects source'
    end

    context 'with inline privacy' do
      let(:source) do
        <<-PRIVACY.undent
          class Foo
            def bar
            end

            private def quux
            end

            protected def quack
            end
          end
        PRIVACY
      end
      let(:corrected_source) do
        <<-EOF.undent
          class Foo
            def bar
            end

            def quack
            end
            protected :quack

            def quux
            end
            private :quux
          end
        EOF
      end
      let(:expected_offenses) do
        [{
          message: '`protected` method out of order.',
          severity: :convention,
          line: 8,
          column: 2,
          source: "protected def quack\n  end"
        }]
      end

      include_examples 'reports offenses'
      # include_examples 'autocorrects source'
    end

    context 'with mixed-mode privacy' do
    end
  end

  context 'when multiple methods are out of order' do
    # TODO: fill out these examples
  end
end
