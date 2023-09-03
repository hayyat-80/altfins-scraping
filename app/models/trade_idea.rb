class TradeIdea < ApplicationRecord
  belongs_to :user
  belongs_to :currency_pair
end
