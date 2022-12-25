require 'spec_helper'

describe ChinaBank::PayrollTextFile::File do
  describe "existing clients" do
    let(:file) do
      described_class.new account_type: "SA",
                          account_number: "1850889513",
                          bank_code: "102",
                          transactions: [
                            {
                              account_type: "CA",
                              account_number: "2030347812",
                              bank_code: "102",
                              amount: BigDecimal("12965.50")
                            },
                            {
                              account_type: "SA",
                              account_number: "4031759684",
                              bank_code: "102",
                              amount: BigDecimal("10350.35")
                            },
                            {
                              account_type: "CA",
                              account_number: "110056741211",
                              amount: BigDecimal("9150.00")
                            },
                            {
                              account_type: "SA",
                              account_number: "110005377015",
                              amount: BigDecimal("21465.85")
                            }
                          ]
    end

    # File content:
    # *CA2030347812   00000012965.50 C102*
    # *SA4031759684   00000010350.35 C102*
    # *CA110056741211 00000009150.00 C888*
    # *SA110005377015 00000021465.85 C888*
    # *SA1850889513   00000053931.70 D102*
    let(:expected_content) { File.read "spec/fixtures/payroll_text_file.txt" }

    example { expect(file.content).to eq expected_content }
  end

  describe "new clients" do
    let(:file) do
      ChinaBank::PayrollTextFile.generate account_number: "1850889513",
                                          bank_code: "102",
                                          transactions: [
                                            {
                                              account_number: "2030347812",
                                              bank_code: "102",
                                              amount: BigDecimal("12965.50")
                                            },
                                            {
                                              account_number: "4031759684",
                                              bank_code: "102",
                                              amount: BigDecimal("10350.35")
                                            },
                                            {
                                              account_number: "110056741211",
                                              amount: BigDecimal("9150.00")
                                            },
                                            {
                                              account_number: "110005377015",
                                              amount: BigDecimal("21465.85")
                                            }
                                          ]
    end

    # File content:
    # *002030347812   00000012965.50 C102*
    # *004031759684   00000010350.35 C102*
    # *00110056741211 00000009150.00 C888*
    # *00110005377015 00000021465.85 C888*
    # *001850889513   00000053931.70 D102*
    let(:expected_content) { File.read "spec/fixtures/new_payroll_text_file.txt" }

    example { expect(file.content).to eq expected_content }
  end
end
