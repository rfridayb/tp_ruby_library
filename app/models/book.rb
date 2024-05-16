class Book < ApplicationRecord
   has_many :borrows
   def borrowed?
     borrows.exists?(ended_at: nil)
   end
end
