class Staff < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'スタッフA' },
    { id: 2, name: 'スタッフB' },
    { id: 3, name: 'スタッフC' },
    { id: 4, name: 'スタッフD' },
    { id: 5, name: 'スタッフE' },
  ]
  include ActiveHash::Associations
  has_many :reservations
end
