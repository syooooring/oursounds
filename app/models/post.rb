class Post < ApplicationRecord
  belongs_to :user
  self.inheritance_column = :_type_disabled
end
