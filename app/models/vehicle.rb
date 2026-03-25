class Vehicle < ApplicationRecord
  has_one_attached :photo

  enum :estado, {
    available: "disponivel",
    reserved: "reservado",
    sold: "vendido"
  }, prefix: true
end
