class Scraping < ActiveRecord::Migration
  def up
    add_column :ski_resorts, :scrape_url, :text
    add_column :ski_resorts, :scrape_selector, :text
    add_column :ski_resorts, :scrape_regex, :text
    add_column :ski_resorts, :value, :text
  end

  def down
    remove_column :ski_resorts, :scrape_url
    remove_column :ski_resorts, :scrape_selector
    remove_column :ski_resorts, :scrape_regex
    remove_column :ski_resorts, :value
  end
end
