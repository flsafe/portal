# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  bio             :text
#  address1        :string
#  address2        :string
#  city            :string
#  state           :string
#  zip             :string
#  password_digest :string
#  role            :integer          default(1)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  school_id       :integer
#  company_id      :integer
#  type            :string
#  avatar          :string
#  phone           :string
#  github_token    :string
#  semester        :integer
#  year            :integer
#  campus_id       :integer
#  grad_year       :integer
#

class Student < User
  belongs_to :campus
  has_many :applications
  has_many :opportunities, through: :applications

  enum semester: {spring: 0, summer: 1, fall: 2, winter: 3}

  validates :avatar,
            :github_token,
            :first_name,
            :phone,
            :last_name,
            :address1,
            :city,
            :state,
            :zip,
            :semester,
            :year,
            :campus_id,
            presence: true

  def self.current_semester
    Student.semesters.invert[(Date.today.month - 1) / 3]
  end

  def self.school_directories(school_ids)
    school_ids = [*school_ids]
    Student.joins(campus: :school).where('schools.id' => school_ids)
  end
end
