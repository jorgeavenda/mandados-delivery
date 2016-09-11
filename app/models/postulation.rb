class Postulation < ActiveRecord::Base
	validates :email, presence: { message: "Especifique email" }
	validates :address, presence: { message: "Especifique direccion" }
end
