class CookThisRecipe::Scraper

  def scrape_main_page(index_url)
    category_page = index_url +  "/recipes/?grouping=all"
    category_array = []
    source = Nokogiri::HTML(open(category_page))

    source.css('#herolinks .grid a').each do |category|
      category_url = index_url + category.attribute('href').text
      name = category.attribute('title').text
      category_hash={ name: name, category_url: category_url}
      category_array << category_hash
    end
    category_array
  end

  def scrape_category_page(index_url)
    category_page = index_url
    category_array = []
    source = Nokogiri::HTML(open(category_page))

    source.css('.hub-daughters .hub-daughters__wrap .hub-daughters__container li span a').each do |item|
      category_url = 'http://allrecipes.com' +  item.attribute('href').text
      name = item.css('.category-title').text
      category_hash={ name: name, category_url: category_url}
      category_array << category_hash
    end
    category_array
  end

  def scrape_recipe_page(index_url)
    category_page = index_url
    category_array = []
    source = Nokogiri::HTML(open(category_page))

    source.css('#grid article a h3').each do |recipe|
      puts recipe.text
    end
  end


end


