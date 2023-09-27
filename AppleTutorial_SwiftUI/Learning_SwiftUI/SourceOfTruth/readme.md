Defining the source of truth using a custom binding

Provide an alternative to a state variable by using a custom binding.

The most common way to define a source of truth that binds to other views in your app is to declare a state variable using the State property wrapper. However, there may be those rare occasions when the source of truth is dynamic and can’t be defined using the @State attribute. For instance, this sample app needs to retrieve a recipe as the source of truth using the recipe’s id. The app accomplishes this by creating a computed property that returns a custom binding.
