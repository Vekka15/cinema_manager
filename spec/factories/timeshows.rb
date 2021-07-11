FactoryBot.define do
  factory :timeshow do
    user { nil }
    movie { nil }
    start_time { Time.current }
    price { 1 }
  end
end
