class Menu < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'カット', time: 1.0 },
    { id: 2, name: 'カラー', time: 1.0 },
    { id: 3, name: 'パーマ', time: 1.0 },
    { id: 4, name: 'トリートメント', time: 1.0 },
    { id: 5, name: 'カット・カラー', time: 2.0 },
    { id: 6, name: 'カット・パーマ', time: 2.0 },
    { id: 7, name: 'カット・トリートメント', time: 2.0 },
    { id: 8, name: 'カラー・パーマ', time: 2.0 },
    { id: 9, name: 'カラー・トリートメント', time: 2.0 },
    { id: 10, name: 'パーマ・トリートメント', time: 2.0 },
    { id: 11, name: 'カット・カラー・パーマ', time: 3.0 },
    { id: 12, name: 'カット・カラー・トリートメント', time: 3.0 },
    { id: 13, name: 'カット・パーマ・トリートメント', time: 3.0 },
    { id: 14, name: 'カラー・パーマ・トリートメント', time: 3.0 },
    { id: 15, name: 'カット・カラー・パーマ・トリートメント', time: 4.0 },
  ]
  include ActiveHash::Associations
  has_many :reservations
end
