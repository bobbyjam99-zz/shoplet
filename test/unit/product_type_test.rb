require 'test_helper'

class ProductTypeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "nameが不正だと検証エラー" do
    p = ProductType.new
    assert !p.valid?
    assert p.errors.invalid?(:name)
  end
end
