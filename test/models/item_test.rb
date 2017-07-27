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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should belong_to :todo

  should validate_presence_of(:name)
end
