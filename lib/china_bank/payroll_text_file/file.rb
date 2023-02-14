require "active_support/core_ext/enumerable"

module ChinaBank
  module PayrollTextFile
    # Describes the payroll text file's content including the lines that builds it.
    class File
      # @param [String] account_number
      # @param [String] account_type
      # @param [String] bank_code
      # @param [Array<Hash>] transactions
      def initialize(account_number:, account_type: "00", bank_code: "888", transactions: [])
        @account_number = account_number
        @account_type = account_type
        @bank_code = bank_code
        @transactions = transactions
      end

      # @return [String]
      def content
        (credit_lines + [debit_line]).join(new_line) + new_line
      end

      # @return [Array<ChinaBank::PayrollTextFile::Line>
      def credit_lines
        transactions.map { |transaction| Line.new(**transaction.merge(transaction_type: Line::TYPES[:credit])) }
      end

      # @return [ChinaBank::PayrollTextFile::Line]
      def debit_line
        Line.new account_number: account_number,
                 account_type: account_type,
                 bank_code: bank_code,
                 transaction_type: Line::TYPES[:debit],
                 amount: total
      end

      private

      attr_reader :account_number,
                  :account_type,
                  :bank_code,
                  :transaction_type,
                  :transactions

      def total
        transactions.sum(BigDecimal 0) { |transaction| transaction.fetch :amount }
      end

      def new_line
        "\r\n"
      end
    end
  end
end
