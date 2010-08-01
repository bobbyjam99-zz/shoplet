class CreateProductCategories < ActiveRecord::Migration
  class ProductType < ActiveRecord::base; end
  class ProductCategory < ActiveRecord::base; end

  def self.up
    create_table :product_categories do |t|
      t.integer :product_type_id
      t.string :name

      t.timestamps
    end

    data

    #products と product_categories の結合テーブルを作成
    create_table :product_categories_products, :id => false do |t|
      t.integer :product_id
      t.integer :product_category_id
      
    end
  end

  def self.data
    book = ProductType.find_by_name 'Book'
    music = ProductType.find_by_name 'Music'
    movie = ProductType.find_by_name 'Movie'

    %w(Computers Mysteries Science¥ Fiction Crime).each do |v|
      ProductCategory.create :product_type_id => book.id, :name => v
    end

    %w(Jazz World¥ Music Electronic Rock Indie Country).each do |v|
      ProductCategory.create :product_type_id => music.id, :name => v
    end

    %w(Action Science¥ Fiction Drama Comedy Thriller).each do |v|
      ProductCategory.create :product_type_id => movie.id, :name => v
    end
  end

  def self.down
    drop_table :product_categories_products rescue nil
    drop_table :product_categories
  end
end
