FactoryBot.define do
  factory :point_master do
    amount { 100 }
    price { 120 }
    started_at { DateTime.now }
    ended_at { '2025-7-18' }
  end
end
