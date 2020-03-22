# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  admin                :boolean          default("false")
#  avatar_content_type  :string
#  avatar_file_name     :string
#  avatar_file_size     :integer
#  avatar_updated_at    :datetime
#  city_state           :string
#  confirmation_sent_at :datetime
#  confirmed_at         :datetime
#  current_sign_in_at   :datetime
#  current_sign_in_ip   :inet
#  email                :string           default(""), not null
#  firstname            :string
#  last_sign_in_at      :datetime
#  last_sign_in_ip      :inet
#  lastname             :string
#  latitude             :float
#  longitude            :float
#  phone                :string
#  pin                  :string
#  remember_created_at  :datetime
#  sign_in_count        :integer          default("0"), not null
#  street_address       :string
#  token                :string
#  token_generated_at   :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot(:user) }

  describe '#generate_token' do
    
  end
end
