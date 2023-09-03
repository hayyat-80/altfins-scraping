class TechnicalAnalysis < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :currency_pair, optional: true
end
