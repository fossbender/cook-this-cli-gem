class CookThisRecipe::Cli

  attr_accessor :categories, :choice, :recipes, :recipe
  attr_reader :flag

  def call
    while again?
      @categories = CookThisRecipe::Scraper.new.scrape_main_page('http://allrecipes.com')
      @flag = true
      puts "\nLet's find some recipes!\n"
      user_choice
      print_categories
      display_recipe
    end
  end


  def user_choice
    while flag
      print_categories
      scrape_category_page
    end
  end


  def print_categories
    puts "\n----------------------------------------------------------\n"
    categories.each.with_index  do |category, i|
      puts "#{i+1}. #{category[:name]}"
    end
  end


  def get_category_choice(page)
    answer = 0
    until answer.between?(1,categories.size) do
        puts "\nEnter the number of the #{page} that interests you:"
        answer = gets.strip.to_i
    end
    @choice = answer-1
    categories[choice][:category_url]
  end


  def scrape_category_page
    temp = CookThisRecipe::Scraper.new.scrape_category_page(get_category_choice( 'category'))
    temp.count > 3 ? @categories = temp : list_recipes
  end


  def list_recipes
    @flag = false
    @recipes = categories[choice][:category_url]
    puts "\nNow listing individual recipes found on the following page:\n#{recipes}\n\n"
    @categories = CookThisRecipe::Scraper.new.scrape_recipe_page(recipes)

  end


  def display_recipe
    CookThisRecipe::Scraper.new.build_recipe(get_category_choice( 'recipe'))
  end


  def again?
    answer = 0
    while answer !=1 && answer !=2
      puts "\n\nWould you like to search for a recipe? Enter 1 for yes, 2 for no:"
      puts "1. yes\n2. no"
      answer = gets.strip.to_i
    end
    answer == 1? true : false
  end

end

