FactoryBot.define do
  factory :point_master do
    amount { 10000 }
    price { 12000 }
    started_at { DateTime.now }
    ended_at { '2025-7-18' }
  end
end
