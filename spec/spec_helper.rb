require 'coverage_helper'

require_relative '../app'

RSpec.configure do |config|
  # Enables colors in output.
  config.color = true

  # This configuration allows you to filter to specific examples or groups by tagging
  # them with :focus metadata. When no example or groups are focused (which should be
  # the norm since it's intended to be a temporary change), the filter will be ignored.
  #
  # RSpec also provides aliases--fit, fdescribe and fcontext--as a shorthand for
  # it, describe and context with :focus metadata, making it easy to temporarily
  # focus an example or group by prefixing an f.
  config.filter_run_when_matching :focus

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
end
