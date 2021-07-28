class Contact < ApplicationRecord
  validates :title, presence: true
  validates :message, presence: true
end
