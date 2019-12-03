# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/xcode_tools_select/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-xcode_tools_select'
  spec.version       = Fastlane::XcodeToolsSelect::VERSION
  spec.author        = 'Vincent HO-SUNE'
  spec.email         = 'vhosune@gmail.com'

  spec.summary       = 'Set the [version] of the default Xcode Command Line Tools path to use.'
  spec.homepage      = "https://github.com/vhosune/fastlane-plugin-xcode_tools_select"
  spec.license       = "MIT"
  spec.description   = "Sets the DEVELOPER_DIR environment, used by fastlane to run Xcode command line tools, to a specific Xcode version found on the current system."

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

end
