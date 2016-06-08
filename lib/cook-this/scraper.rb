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
    category_array = []
    source = Nokogiri::HTML(open(index_url))

    source.css('.hub-daughters .hub-daughters__wrap .hub-daughters__container li span a').each do |item|
      category_url = 'http://allrecipes.com' +  item.attribute('href').text
      name = item.css('.category-title').text
      category_hash={ name: name, category_url: category_url}
      category_array << category_hash
    end
    category_array
  end

  def scrape_recipe_page(index_url)
    category_array = []
    source = Nokogiri::HTML(open(index_url))

    source.css('#grid article a[data-internal-referrer-link="hub recipe"]').each do |recipe|
      name = recipe.css('h3').text.gsub( /\r\n/m, '' ).strip
      if name != ''
        category_url = 'http://allrecipes.com' + recipe.attribute('href').text
        category_hash={ name: name, category_url: category_url}
        category_array << category_hash
      end
    end

    category_array
  end

  def build_recipe(index_url)
    #source = Nokogiri::HTML(open(index_url))
    #CookThisRecipe::Recipe.new_recipe(source)
    CookThisRecipe::Recipe.new_recipe(Nokogiri::HTML(open(index_url)))
  end



end


