class Scenario < ApplicationRecord
  belongs_to :verb
  belongs_to :noun
  belongs_to :event
  belongs_to :requester, class_name: 'User', inverse_of: :requested
  belongs_to :doer, class_name: 'User', inverse_of: :solved
  belongs_to :parent_scenario, class_name: 'Scenario', inverse_of: :children_scenario, optional: true

  has_many :proofs, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_many :children_scenario, class_name: 'Scenario', dependent: :nullify, inverse_of: :parent_scenario, foreign_key: :parent_scenario_id

  # has_many :ads

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def description
    verb.description + ' ' + noun.description + ' for ' + requester.name + ' in ' + event.description
  end

  def parent_description
    return if parent_scenario.nil?

    parent_scenario.description
  end

  def custom_message
    nil
  end

  def requesterlat
    requester.latitude
  end

  def requesterlon
    requester.longitude
  end

  def donated
    "50" # Currently these are default amounts, will need to be calculated
  end

  def funding_goal
    "100" # Currently these are default amounts, will need to be calculated
  end
end
