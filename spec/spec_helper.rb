$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.minimum_coverage 92
SimpleCov.start 'rails'

require 'china_bank/payroll_text_file'
