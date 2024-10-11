# frozen_string_literal: true

require_relative "lib/temp_table/version"

Gem::Specification.new do |spec|
  spec.name = "temp_table"
  spec.version = TempTable::VERSION
  spec.authors = ["Shesh Nath Goswami"]
  spec.email = ["sheshwork08@gmail.com"]
  spec.license = "MIT"

  spec.summary = "To create temproray table."
  spec.description = "You can create the temproray table using this gem so that you can make a temp table and store its data temproraly until the user's session is active."
  spec.homepage = "https://github.com/Shesh-08"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/temp_table"
  # spec.metadata["changelog_uri"] = Dir["lib/**/*", "README.md"]

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
