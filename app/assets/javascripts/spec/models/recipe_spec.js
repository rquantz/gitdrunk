describe("Recipe", function(){
    describe("when instantiated", function(){
        var recipe;

        beforeEach(function() {
            recipe = build_recipe();
        });

        it("has a url based on its id", function(){
            expect(recipe.url()).toEqual("/recipes/1");
        });
        
        it("instantiates a collection of ingredients", function(){
            expect(recipe.ingredients.length).toBe(1)
        });
    });
    
    describe("without ingredients", function(){
        it("has an empty ingredients attribute", function(){
            var recipe = new App.Models.Recipe({
                id: 1,
                cocktail_id: 2,
                tasting_notes: "Delicious",
            });
            expect(recipe.ingredients.length).toBe(0);
        });
    });
});

