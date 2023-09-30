class Producto < ApplicationRecord
  belongs_to :categoria
  validates :nombre, presence: true
end
