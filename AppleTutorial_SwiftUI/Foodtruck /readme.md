[Food Truck: Building a SwiftUI multiplatform app](https://developer.apple.com/documentation/swiftui/food_truck_building_a_swiftui_multiplatform_app)

Create a single codebase and app target for Mac, iPad, and iPhone.

Using the Food Truck app, someone who operates a food truck can keep track of orders, discover the most-popular menu items, and check the weather at their destination. 

The sample implements the new NavigationSplitView to manage the app’s views, Layout to show the main interface and pending orders, Charts to show trends, and WeatherService to get weather data. Food Truck also implements Live Activities to show the remaining order preparation time with ActivityKit on the lock screen, and with DynamicIsland on the home screen.

This app uses a variety of APIs and frameworks:

* Code for the foodtruck app on [GitHub](https://github.com/apple/sample-food-truck) and introductory video at [WWDC22 Platforms State of the Union](https://developer.apple.com/videos/play/wwdc2022/102/)

* Mapkit [framework](https://developer.apple.com/documentation/mapkit)

* Swft Charts [framework](https://developer.apple.com/documentation/charts)
  
* Weatherkit [framework](https://developer.apple.com/documentation/WeatherKit), [sample app](https://developer.apple.com/documentation/weatherkit/fetching_weather_forecasts_with_weatherkit) and [WWDC22 video](https://developer.apple.com/wwdc22/10003/)

* Widgets [overview](https://developer.apple.com/widgets/)
