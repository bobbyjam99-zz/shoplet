class Product < ActiveRecord::Base
  has_and_belongs_to_many :product_categories
  belongs_to :product_type
  validates_presence_of :price, :name, :product_type
  validates_numericality_of :price, :only_integer => true, :greater_than => 0
  validates_each :product_category, :on => :create do |m, attr, value|
    if !value.nil? && value.any? {|v| m.product_type != v.product_type}
      m.errors.add(attr, "とタイプが一致していません。")
    end
  end

  after_update :reprace_product_category

  private
  def replace_product_categories
    self.product_categories = product_categories_to_be_replaced if product_category_to_be_replaced
  end

end
