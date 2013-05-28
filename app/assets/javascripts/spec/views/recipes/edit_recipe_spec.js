describe("EditeRecipe", function(){
    
    describe("when instantiated", function(){
        var edit_recipe_view, recipe;
        
        beforeEach(function(){
            recipe = build_recipe();
            edit_recipe_view = new App.Views.EditRecipe({model: recipe});
        });
        it('has an element', function(){
            expect(edit_recipe_view.$el).toBe('.recipe');
            expect(edit_recipe_view.$el).toBe('.edit_recipe');
        });
    });
});
