# frozen_string_literal: true

require_relative "lib/temp_table/version"

Gem::Specification.new do |spec|
  spec.name = "temp_table"
  spec.version = TempTable::VERSION
  spec.authors = ["Shesh Nath Goswami"]
  spec.email = ["sheshwork08@gmail.com"]
  spec.license = "MIT"

  spec.summary = "To create temporary tables."
  spec.description = "You can create temporary tables using this gem to store data temporarily until the user's session is active."
  spec.homepage = "https://github.com/Shesh-08/temp-table"
  spec.required_ruby_version = ">= 2.6.0"

  # Change allowed_push_host to point to RubyGems
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage # This can also point to your GitHub repo
  spec.metadata["changelog_uri"] = "https://github.com/Shesh-08/temp-table/blob/master/CHANGELOG.md" # Adjust if you have a changelog

  # Specify which files should be added to the gem when it is released.
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
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'activerecord'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
