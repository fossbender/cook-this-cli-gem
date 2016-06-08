class CookThisRecipe::Recipe

  def self.new_recipe(source)
    name = source.css('h1').text

    binding.pry

  end
end