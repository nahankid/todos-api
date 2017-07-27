# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user, aliases: [:creator] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'hello123'
  end
end
