Specifying the source of truth

This sample app displays the details of a recipe in the custom view DetailView. The view only knows the recipe id, 
but not the recipe, so it uses the id to retrieve the recipe from the recipe box (a data store that contains all the recipes).
Because the view needs to retrieve the recipe, it uses a custom binding as the source of truth of the recipe instead of declaring
a state variable for the recipe.

Using a custom binding is a useful feature of SwiftUI, but isn’t always the best option. Limit its use to use cases where using a
state variable or object isn’t possible. In most cases, define the source of truth as either a State variable (for state local to the view)
or StateObject (for shared data models) to let SwiftUI manage the value or object for you.
