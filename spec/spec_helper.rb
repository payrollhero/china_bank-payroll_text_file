$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.minimum_coverage 100
SimpleCov.start 'rails'

require 'china_bank/payroll_text_file'
