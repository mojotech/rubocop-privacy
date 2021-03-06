describe RuboCop::Cop::Privacy::MethodOrder do
  include SharedExamples

  subject(:cop) { described_class.new }

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
           message: '`quux` method out of order',
           severity: :convention,
           line: 7,
           column: 2,
           source: 'def quux'
        }, {
           message: '`quack` method out of order',
           severity: :convention,
           line: 12,
           column: 2,
           source: 'def quack'
        }]
      end

      include_examples 'reports offenses'
      include_examples 'autocorrects source'
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
           message: '`quux` method out of order',
           severity: :convention,
           line: 5,
           column: 2,
           source: 'def quux'
        }, {
           message: '`quack` method out of order',
           severity: :convention,
           line: 9,
           column: 2,
           source: 'def quack'
        }]
      end

      include_examples 'reports offenses'
      include_examples 'autocorrects source'
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
           message: '`quux` method out of order',
           severity: :convention,
           line: 5,
           column: 2,
           source: 'def quux'
        }, {
           message: '`quack` method out of order',
           severity: :convention,
           line: 8,
           column: 2,
           source: 'def quack'
        }]
      end

      include_examples 'reports offenses'
      include_examples 'autocorrects source'
    end

    context 'with mixed-mode privacy' do
    end
  end

  context 'when multiple methods are out of order' do
    # TODO: fill out these examples
  end
end
