require "active_model"

module ChinaBank
  module PayrollTextFile
    # Describes each line on China Bank's payroll text file.
    class Line
      include ActiveModel::Model

      AMOUNT_RANGE = BigDecimal("0")..BigDecimal("99999999999.99")
      TYPES = {
        credit: "C",
        debit: "D"
      }

      attr_accessor :account_type,
                    :account_number,
                    :amount,
                    :transaction_type,
                    :bank_code

      validates :account_type, inclusion: { in: %w[CA SA 00], message: "must be either CA, SA, or 00" }
      validates :account_number, length: { in: 10..12 }, numericality: { only_integer: true }
      validates :amount, inclusion: { in: AMOUNT_RANGE, message: "must be between 0.00 to 99,999,999,999.99" }
      validates :transaction_type, inclusion: { in: TYPES.values, message: "must be either C or D" }
      validates :bank_code, length: { is: 3 }, numericality: { only_integer: true }
      validates :account_type, :account_number, :amount, :transaction_type, :bank_code, presence: true

      # @param [String] account_type
      # @param [String] account_number
      # @param [BigDecimal] amount
      # @param [String] transaction_type
      # @param [String] bank_code
      def initialize(account_type: "00", account_number:, amount:, transaction_type:, bank_code: "888")
        @account_number = account_number
        @account_type = account_type
        @bank_code = bank_code
        @transaction_type = transaction_type
        @amount = BigDecimal(amount.to_s)

        raise ArgumentError, errors.full_messages.to_sentence unless valid?
      end

      # @example: "*SA1850889513   00000053931.70 D102*"
      # @return [String]
      def to_s
        [
          terminator_character,     # "*"
          account_type,             # "SA"
          formatted_account_number, # "1850889513  "
          spacer,                   # " "
          formatted_amount,         # 00000053931.70
          spacer,                   # " "
          transaction_type,         # "D"
          bank_code,                # "102"
          terminator_character      # "*"
        ].join
      end

      private

      def terminator_character
        "*"
      end

      def spacer
        " "
      end

      def formatted_account_number
        account_number.ljust(12)
      end

      def formatted_amount
        "%014.2f" % amount
      end
    end
  end
end
