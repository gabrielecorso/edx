class Movie < ActiveRecord::Base

  def self.allratingvalues
    allratingvalues = []
    self.all(:select => "rating", :group => "rating").each do |rr|
      allratingvalues << rr[:rating]
    end
    return allratingvalues
  end
end
