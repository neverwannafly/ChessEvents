class Rating < ApplicationRecord
  self.inheritance_column = :owner_type

  belongs_to :owner, polymorphic: true
end
