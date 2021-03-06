# == Schema Information
#
# Table name: opportunities
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  city               :string
#  state              :string
#  is_open            :boolean
#  is_affilated       :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :integer
#  skills             :text
#  requirements       :text
#  employer_id        :integer
#  applications_count :integer
#

class Opportunity < ActiveRecord::Base
  belongs_to :company
  belongs_to :employer
  has_many :applications

  validates :company, :employer, :title, :description, :city, :state, presence: true

  def self.through_partners(school)
    ids = Opportunity.joins(company: {employers: :partnerships})
                     .select('DISTINCT opportunities.id')
                     .where('partnerships.school_id = ?', school.id)
    Opportunity.includes(:company).where(id: ids).order('opportunities.created_at DESC')
  end

  def self.get_application_counts(opportunities, application_state)
    Opportunity.joins(
      "JOIN applications ON applications.opportunity_id = opportunities.id AND applications.application_state = '#{application_state}'"
    ).where(id: opportunities.map(&:id))
     .group('opportunities.id').count 
  end
end
