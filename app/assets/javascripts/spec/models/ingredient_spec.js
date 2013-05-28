describe("Ingredient", function(){
    
    describe("when instantiated", function(){
        var ingredient;

        beforeEach(function(){
            ingredient = new App.Models.Ingredient({
                id: 1,
                amount: "1 oz",
                spirit_name: "Gin"
            })
        });
        
        it("has a url based on its id", function(){
            expect(ingredient.url()).toEqual("/ingredients/1");
        });
        

    });

});
