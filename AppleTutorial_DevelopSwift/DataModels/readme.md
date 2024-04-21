Data modeling

Use SwiftData to store and load information for your app.

- - - -

What you’ll learn

How to model your own data types in Swift to represent real-world concepts

The fundamentals of [SwiftData](https://developer.apple.com/documentation/swiftdata), which you can use to power apps with any kind of data you can imagine

How to work with Xcode previews to design an interface around your data model

- - - -

About data modeling

Data modeling is the art of representing real-world concepts as models in your code. You have already had some experience with this in SwiftUI foundations. When you rolled dice in Update the UI with state, you modeled a dice using a single number. Similarly, you modeled a group of your pals as an array of strings in Create dynamic content — but, as you might remember, if you added a list of friends in the simulator, the list was lost each time you ran your app.

The Pick-a-Pal app forgets its list of names because it uses a @State property to manage them. That’s fine for a prototype, but people expect apps to remember the data they’re working with. And suppose you wanted to track how many times each friend was chosen in Pick-a-Pal. Doing so by adding another array of built-in types would be cumbersome.

To take your apps to the next level, you can create your own model types that better express your data and the relationships between them. Then you can add these models to SwiftData to get a powerful data store that persists data across the many times people open your app. SwiftData works with SwiftUI to manage a two-way connection between your views and the data they rely on.
