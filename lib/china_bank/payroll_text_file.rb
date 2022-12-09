require "china_bank/payroll_text_file/version"
require "bigdecimal"
require "active_support"

module ChinaBank
  # Generates a payroll text file compatible with China Bank Auto Credit Arrangement (ACA).
  #
  # @example:
  #   ChinaBank::PayrollTextFile.generate account_number: ,
  #                                       account_type: ,
  #                                       branch_code: ,
  #                                       transaction_type: ,
  #                                       transactions: [
  #                                         {
  #                                           amount: ,
  #                                           account_number: ,
  #                                           account_type: ,
  #                                           branch_code: ,
  #                                           transaction_type:
  #                                         }
  #                                       ]
  module PayrollTextFile
    extend ActiveSupport::Autoload

    autoload :File
    autoload :Line

    class << self
      # @param [Hash] options
      # @return [ChinaBank::PayrollTextFile::File]
      def generate(**options)
        File.new **options
      end
    end
  end
end
