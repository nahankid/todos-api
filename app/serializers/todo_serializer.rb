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

class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :creator, class_name: 'User'
end
