class CookThisRecipe::Cli

  attr_accessor :categories, :choice, :recipes
  attr_reader :flag

  def call
    @categories = CookThisRecipe::Scraper.new.scrape_main_page('http://allrecipes.com')
    @flag = true
    puts 'Let\'s find some recipes!'
    user_choice
    print_categories
    grab_recipe
  end

  #while there are still more than 3 categories to drill down, keep listing them and scraping
  def user_choice
    while flag
      print_categories
      scrape_category_page
    end
  end

  #print the categories of recipes
  def print_categories
    count = 1
    categories.each do |category|
      puts "#{count}. #{category[:name]}"
      count += 1
    end
  end


  def get_category_choice
    puts 'Enter the number of the item that interests you'
    @choice = gets.strip.to_i-1
    categories[choice][:category_url]

  end


  def scrape_category_page
    temp = CookThisRecipe::Scraper.new.scrape_category_page(get_category_choice)
    temp.count > 3 ? @categories = temp : list_recipes
  end


  def list_recipes
    @flag = false
    @recipes = categories[choice][:category_url]
    puts "Now listing individual recipes found on the following page: #{recipes}"
    @categories = CookThisRecipe::Scraper.new.scrape_recipe_page(recipes)

  end

  def grab_recipe
    CookThisRecipe::Scraper.new.build_recipe(get_category_choice)
  end



end


#maybe use this later
###def start
###  answer = 1
###  ingredients = {include: [], exclude: []}
###  while answer != 3
###    puts 'Would you like to include or exclude an ingredient?'
###    puts "1. Include \n2. Exclude \n3. I'm done - find my recipes!"
###    answer = gets.strip.to_i
###    case answer
###      when 1
###        puts 'which ingredients would you like to include?'
###        ingredients[:include] << gets.strip
###      when 2
###        puts 'which ingredients would you like to exclude?'
###        ingredients[:exclude] << gets.strip
###    end
###  end
###  ingredients
###end



#maybe use this later
###def build_search_string
###  # {
###  # :include=>["apple", "banana", "allspice"],
###  # :exclude=>["carrot", "daikon", "daikon"]
###  # }
###  #puts "in build_search_string calling start method returns: #{start}"
###end

