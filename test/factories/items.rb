# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  done       :boolean
#  todo_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_items_on_todo_id  (todo_id)
#

FactoryGirl.define do
  factory :item do
    todo
    name { Faker::Name.name }
    done false

    trait :complete do
      done true
    end
  end
end
