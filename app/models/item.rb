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

class Item < ApplicationRecord
  belongs_to :todo

  validates :name, presence: true
end
