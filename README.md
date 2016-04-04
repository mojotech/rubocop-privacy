# RuboCop Privacy

Vertical alignment analysis for Ruby files.

## Installation

Install the `rubocop-privacy` gem

```bash
gem install rubocop-privacy
```

or add it to your Bundler Gemfile

```ruby
gem 'rubocop-privacy'
```

## Usage

Tell RuboCop to load the Privacy extension.  There are a few ways to accomplish this:

### RuboCop configuration file

Put this into your `.rubocop.yml` file:

```yaml
require: rubocop-privacy
```

Now just run `rubocop` and it will automatically load the RuboCop Privacy cop in addition
to your standard Cops.

### Command line

```bash
rubocop --require rubocop-privacy
```

### Rake task

```ruby
RuboCop::RakeTask.new do |t|
  t.requires << 'rubocop-privacy'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

For running the spec files, this project depends on RuboCop's spec helpers. This means that in order to run the specs locally, you need a (shallow) clone of the RuboCop repository:

```bash
git submodule update --init --depth 1 vendor/rubocop
```

## License

`rubocop-privacy` is MIT licensed.  [See the accompanying LICENSE file][1] for the full text.

[1]: LICENSE.md
