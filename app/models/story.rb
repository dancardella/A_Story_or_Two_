class Story < ActiveRecord::Base
  attr_accessible :title
  has_many :lines
  has_many :submissions
end
