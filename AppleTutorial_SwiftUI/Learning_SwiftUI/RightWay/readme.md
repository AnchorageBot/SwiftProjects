[Conditionally removing a view](https://developer.apple.com/tutorials/swiftui-concepts/choosing-the-right-way-to-hide-a-view)

Your design might have a login screen that doesn’t show an error message the first time it appears, but adds an error message
after someone mistypes their password. The user name and password fields shouldn’t shift position depending on whether the
error message is visible. Use an opacity(_:) modifier with a value of 0 so that the layout accounts for the error message whether
or not it’s visible. You can also use this strategy for removing a view that doesn’t affect other views’ placement,
like a view inside an overlay(alignment:content:) modifier.
 
Or, you might have an order Form that displays a second set of address fields if a person chooses not to use the same address
for their shipping and billing addresses. For content like address fields that people might need to scroll past, use an if statement
to only make room for the content when it’s visible, and shift other content as it appears and disappears.

If you need to reserve space in a layout based on the measurement of a view, but never want to show that view, you can use the hidden()
modifier.

VoiceOver and gesture recognizers also ignore a view that you remove in any of these ways.

To show the differences between these approaches, this example uses a sequence of train cars. Each train has three views — a front, middle,
and rear section — and uses the train car symbols from SF Symbols. For a long train, the front, middle, and rear car all appear. For a shorter
train, the middle car doesn’t appear. The code that defines each train uses a different technique to omit the middle car.
