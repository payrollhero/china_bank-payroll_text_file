# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'china_bank/payroll_text_file/version'

Gem::Specification.new do |spec|
  spec.name          = "china_bank-payroll_text_file"
  spec.version       = ChinaBank::PayrollTextFile::VERSION
  spec.authors       = ["Ronald Maravilla"]
  spec.email         = ["rmaravilla@payrollhero.com"]

  spec.summary       = %q{A payroll text file generator for China Bank}
  spec.description   = %q{A payroll text file generator for China Bank}
  spec.homepage      = "https://github.com/payrollhero/china_bank-payroll_text_file"
  spec.license       = "BSD-3-Clause"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "activesupport"
  spec.add_dependency "activemodel"
end
