FactoryBot.define do

  factory :customer do
    first_name { Faker::Name.neutral_first_name }
    last_name { Faker::Name.last_name }
  end

  factory :merchant do
    name { Faker::Name.name_with_middle }
  end

  factory :item do
    merchant
    name { Faker::App.name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price }
  end

  factory :invoice do
    customer
    merchant
    status { "not shipped" }
  end

  factory :purchase do
    invoice
    credit_card_number { Faker::Finance.credit_card }
    credit_card_expiration_date { Faker::Date.between(from: 1.year.from_now, to: 2.years.from_now).strftime }
    result { rand(2).zero? ? "success" : "failed" }
  end

  factory :invoice_item do
    invoice
    item
    quantity {}
    unit_price {}
  end

end
