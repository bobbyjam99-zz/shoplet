require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test 'name がないと検証エラー' do
    p = Product.new
    assert !p.valid?
    assert p.errors.invalid?(:name)
  end

  test 'product_type がないと検証エラー' do
    p = Product.new
    assert !p.valid?
    assert p.errors.invalid?(:product_type)
  end

  test '新しく作成した product のカテゴリが不正なら検証エラー' do
    p = Product.new
    p.product_type = product_types('book')
    c = ProductCategory.create :name => 'ABC', :product_type => product_types('music')
    p.product_categories << c
    assert !p.valid?
    assert p.errors.invlid?(:product_categories)
  end

  test '保存済みの product のカテゴリが不正なら検証エラー' do
    p = Product.new(:price => 12, :name => "Hello Goodbye")
    p.product_type = product_types('book')
    c = ProductCategory.create :name => 'XYZ', :product_type => product_types('book')
    p.product_categories << c
    p.save!
    c = ProductCategory.create :name => 'ABC', :product_type => product_types('music')
    p.product_categories_to_be_replaced = [c]
    assert !p.valid?
    assert p.errors.invalid?(:prodct_categories)
  end

  test 'price が不正だと検証エラー' do
    p = Product.new
    p.price = nil
    assert !p.valid?
    assert p.errors.invalid?(:price)
    p = Product.new
    p.price = 1.0
    assert !p.valid?
    assert p.errors.invalid?(:price)
    p = Product.new
    p.price = 0
    assert !p.valid?
    assert p.errors.invalid?(:price)
    p = Product.new
    p.price = -17
    assert !p.valid?
    assert p.errors.invalid?(:price)
  end

  test '正しい product が検証を通る' do
    p = Product.new
    p.price = 122
    p.name = "Hello Goodbye"
    p.product_type = product_types('book')
    assert p.valid?
  end
end
