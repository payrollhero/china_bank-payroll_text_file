require 'spec_helper'

describe ChinaBank::PayrollTextFile::Line do

  subject(:line) do
    described_class.new account_type: account_type,
                        account_number: account_number,
                        amount: amount,
                        transaction_type: transaction_type,
                        bank_code: bank_code

  end

  let(:account_type) { 'CA' }
  let(:account_number) { '123456789012' }
  let(:amount) { BigDecimal('99999999999.99') }
  let(:transaction_type) { 'C' }
  let(:bank_code) { '102' }

  example { expect("#{line}").to eq '*CA123456789012 99999999999.99 C102*' }

  describe 'validations' do
    describe 'valid' do
      example { expect { line }.to_not raise_exception }
    end

    describe 'invalid account type' do
      let(:account_type) { '01' }

      example { expect { line }.to raise_exception ArgumentError, 'Account type must be either CA, SA, or 00' }
    end

    describe 'invalid account number' do
      context 'too short' do
        let(:account_number) { '01' }

        example { expect { line }.to raise_exception ArgumentError, 'Account number is too short (minimum is 10 characters)' }
      end

      context 'too long' do
        let(:account_number) { '1234567890123' }

        example { expect { line }.to raise_exception ArgumentError, 'Account number is too long (maximum is 12 characters)' }
      end

      context 'invalid character' do
        let(:account_number) { '1234567890+2' }

        example { expect { line }.to raise_exception ArgumentError, 'Account number is not a number' }
      end
    end

    describe 'invalid amount' do
      let(:amount) { BigDecimal('-0.01') }

      example { expect { line }.to raise_exception ArgumentError, 'Amount must be between 0.00 to 99,999,999,999.99' }
    end

    describe 'invalid account type' do
      let(:transaction_type) { 'A' }

      example { expect { line }.to raise_exception ArgumentError, 'Transaction type must be either C or D' }
    end

    describe 'invalid bank code' do
      context 'incorrect length' do
        let(:bank_code) { '01' }

        example { expect { line }.to raise_exception ArgumentError, 'Bank code is the wrong length (should be 3 characters)' }
      end

      context 'invalid character' do
        let(:bank_code) { '1+3' }

        example { expect { line }.to raise_exception ArgumentError, 'Bank code is not a number' }
      end
    end
  end
end
