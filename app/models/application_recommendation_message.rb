class ApplicationRecommendationMessage < ActivityMessage
  validates :staffer, :application, presence: true
end