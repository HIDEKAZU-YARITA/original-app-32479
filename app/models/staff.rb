class Staff < ApplicationRecord
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'Staff A' },
    { id: 2, name: 'Staff B' },
    { id: 3, name: 'Staff C' },
    { id: 4, name: 'Staff D' },
    { id: 5, name: 'Staff e' },
  ]
  include ActiveHash::Associations
  has_many :reservations
end
