class Product < ActiveRecord::Base

  has_many   :line_items
  
  validates_presence_of  :title, :description
  validates_numericality_of  :price

  validates_length_of :title, :minimum => 10, 
			      :message => "is too short"

  validate :price_must_be_at_least_a_penny

  def self.find_products_for_sale
    find(:all, :order => "title")
  end


  protected 

    def price_must_be_at_least_a_penny
      errors.add(:price, 'should be at least 0.01') if price.nil? || price < 0.01
    end

end


