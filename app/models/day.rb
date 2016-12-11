class Day < ActiveRecord::Base
  belongs_to :bar
  validates_uniqueness_of :bar_id, scope: [:day, :hour]

end
