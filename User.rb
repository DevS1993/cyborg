class User

  DEFAULT_VALUES = {
    "bank_ifsc_code" => "ICIC0000001",
    "bank_account_number" => "11111111",
    "amount" => "10000.00",
    "merchant_transaction_ref" => "txn001",
    "transaction_date" => "2014-11-14",
    "payment_gateway_merchant_reference" => "merc001",
  }

  def self.getInput
    self.printWelcomeMessage
    input = gets.chomp
    if input.downcase.eql?("yes")
      self.getValues
    else
      DEFAULT_VALUES
    end
  end

  def self.printWelcomeMessage
    puts "Would you like to enter IFSC code, Bank Account Number, Amount?"
    puts "Yes, to enter."
    puts "No, to use the default values."
  end

  def self.getValues
    puts "Enter IFSC code: "
    ifsc = self.validate(gets.chomp, "IFSC Code")
    puts "Enter Bank Account Number: "
    ac_no = self.validate(gets.chomp, "Account Number")
    puts "Enter Amount: "
    amt = self.validate(gets.chomp, "Amount")
    {
      "bank_ifsc_code" => ifsc ,
      "bank_account_number" => ac_no,
      "amount" => amt.amt,
      "merchant_transaction_ref" => "txn001",
      "transaction_date" => Time.now.strftime("%Y-%d-%m"),
      "payment_gateway_merchant_reference" => "merc001",
    }
  end

  def self.validate input, type
    if input.empty?
      puts "No input received for #{type}. Try again."
      exit
    end
    input
  end
end
