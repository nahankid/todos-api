# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#
# Indexes
#
#  index_todos_on_creator_id  (creator_id)
#

require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  should belong_to(:creator)
  should have_many(:items).dependent(:destroy)

  should validate_presence_of(:title)
end
