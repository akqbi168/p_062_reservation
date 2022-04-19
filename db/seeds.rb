# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(name: 'aa', password: 'aaaaaa', email: 'aa@aa.com')
User.create(name: 'bb', password: 'bbbbbb', email: 'bb@bb.com')
User.create(name: 'cc', password: 'cccccc', email: 'cc@cc.com')
User.create(name: 'dd', password: 'dddddd', email: 'dd@dd.com')
User.create(name: 'ee', password: 'eeeeee', email: 'ee@ee.com')


Property.create(
  user_id: 1,
  name: 'THE TOKYO CONRAD',
  postal_code: '1234567',
  country: '日本',
  city: 13,
  address: '港区芝浦1-2-3',
  introduction: '東京湾を臨むベイエリアに最新設備を兼ね揃えたお部屋をご用意しました。',
  if_dynamic_pricing: true,
  base_price: 6000,
  min_price: 3000,
  max_price: 9000,
  reservation_fee: 1000,
  max_capacity: 4
)
Property.create(
  user_id: 1,
  name: 'Tokyo Sky Suites',
  postal_code: '1234567',
  country: '日本',
  city: 13,
  address: '渋谷区神宮前2-4-6',
  introduction: '明治神宮まで徒歩圏内。渋谷区の緑の杜に誕生したダブルベット完備のお部屋です。',
  if_dynamic_pricing: true,
  base_price: 9000,
  min_price: 7000,
  max_price: 12000,
  max_capacity: 2
)
Property.create(
  user_id: 1,
  name: 'ソノリティ江戸浅草',
  postal_code: '1234567',
  country: '日本',
  city: 13,
  address: '台東区浅草寺3-6-9',
  introduction: 'コンパクトで機能的なお部屋をお探しの方はこちら! 浅草寺まで徒歩30秒。',
  if_dynamic_pricing: true,
  base_price: 9800,
  min_price: 7000,
  max_price: 12000,
  max_capacity: 1
)
Property.create(
  user_id: 2,
  name: '大阪天満スイートヴィラ',
  postal_code: '1234567',
  country: '日本',
  city: 27,
  address: '大阪市北区1-2-3',
  introduction: '大阪駅より1駅。あべのハルカスとほぼ同じ高さのスイートルームでは、都会の喧騒を忘れさせてくれる一流の空間を提供します',
  if_dynamic_pricing: true,
  base_price: 12000,
  min_price: 9000,
  max_price: 20000,
  max_capacity: 4
)
Property.create(
  user_id: 2,
  name: 'なんばスカイオウレジデンス',
  postal_code: '1234567',
  country: '日本',
  city: 27,
  address: '大阪市中央区1-2-3',
  introduction: 'なんばのど真ん中に鎮座。',
  if_dynamic_pricing: true,
  base_price: 5000,
  min_price: 3500,
  max_price: 12000,
  max_capacity: 2
)
Property.create(
  user_id: 2,
  name: '東京の何処',
  postal_code: '1234567',
  country: '日本',
  city: 13,
  address: '西東京郡東東京1234-5-6',
  introduction: '東京にあるのは間違いないと思います。たぶん山の近くでしょう。',
  if_dynamic_pricing: true,
  base_price: 5000,
  min_price: 3500,
  max_price: 12000,
  reservation_fee: 3000,
  max_capacity: 9
)


for d in Date.new(2022,03,01)..Date.new(2022,05,31) do
  entity = Entity.new(
    property_id: 1,
    date: d,
    price_ratio: 0
  )
  entity.save
end

for d in Date.new(2022,03,01)..Date.new(2022, 5, 8) do
  entity = Entity.new(
    property_id: 2,
    date: d,
    price_ratio: 0
  )
  entity.save
end

for d in Date.new(2022,03,01)..Date.new(2022, 5, 8) do
  entity = Entity.new(
    property_id: 3,
    date: d,
    price_ratio: 0
  )
  entity.save
end

for d in Date.new(2022,03,01)..Date.new(2022,05,31) do
  entity = Entity.new(
    property_id: 4,
    date: d,
    price_ratio: 0
  )
  entity.save
end

for d in Date.new(2022,03,01)..Date.new(2022, 5, 8) do
  entity = Entity.new(
    property_id: 5,
    date: d,
    price_ratio: 0
  )
  entity.save
end

Entity.where(occupied_status: nil).update_all(occupied_status: 1)
