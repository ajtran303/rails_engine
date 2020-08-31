FactoryBot.define do

  factory :customer do
    first_name {}
    last_name {}
  end

  factory :merchant do
    name {}
  end

  factory :item do
    merchant
    name {}
    description {}
    unit_price {}
  end

  factory :invoice do
    customer
    merchant
    status {}
  end

  factory :purchase do
    invoice
    credit_card_number {}
    credit_card_expiration_date {}
    result {}
  end

  # factory :invoice_item do
  #   invoice
  #   item
  #   quantity {}
  #   unit_price {}
  # end

end
