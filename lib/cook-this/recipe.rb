class CookThisRecipe::Recipe

  attr_reader :source, :name, :rating, :total_reviews
  attr_accessor :ingredients, :instructions

  @@all = []

  def self.new_recipe(source)
    @source = source
    @name = source.css('h1').text
    @rating =  source.css('.recipe-summary meta[property="og:rating"]').first.attributes['content'].value.to_f
    @total_reviews = source.css('.recipe-summary a span.review-count').text
    @ingredients = []
    @instructions = []
    display
  end


  def self.display
    self.show_name
    self.show_rating
    self.show_ingredients
    self.show_instructions
  end

  def self.show_name
    puts "\n****************************************************************"
    puts "****************************************************************\n"
    puts "Now viewing the recipe for: #{@name}"
    puts "\n****************************************************************"
    puts "****************************************************************\n"
  end

  def self.show_rating
    puts "\nThe recipe is rated #{@rating.round(3)} out of #{@total_reviews}.\n"
  end

  def self.show_ingredients
    make_ingredients
    puts "\n------------------------------------------------------------------\n"
    puts "#{@name} Ingredients:"
    puts "------------------------------------------------------------------\n"
    @ingredients.each_with_index do |ingredient,i |
      puts "#{i+1}. #{ingredient}"
    end
  end

  def self.make_ingredients
    @source.css('.recipe-ingredients ul li label span[itemprop="ingredients"]').each do |ingredient|
      @ingredients << ingredient.text
    end

  end

  def self.show_instructions
    make_instructions
    puts "\n------------------------------------------------------------------\n"
    puts "Instructions for making #{@name}"
    puts "------------------------------------------------------------------\n"
    @instructions.each_with_index do |instruction,i |
      puts "\n#{i+1}. #{instruction}\n"
    end
  end

  def self.make_instructions
    @source.css('.recipe-directions ol')[0].css('li span').each do |instruction|
      @instructions << instruction.text
      end
  end

end