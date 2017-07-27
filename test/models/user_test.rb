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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_secure_password

  should have_many(:todos).dependent(:destroy)

  should validate_presence_of(:name)
  should validate_presence_of(:email)
  should validate_presence_of(:password_digest)
end
