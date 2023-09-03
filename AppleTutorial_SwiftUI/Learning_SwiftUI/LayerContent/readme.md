View layout

[Layering content](https://developer.apple.com/tutorials/swiftui-concepts/layering-content)

Define views in an overlay or background to adapt their layout to the primary content.

Designs that layer content often specify that some content stays within the bounds of other content, or maintains
a specific margin around that content. You can define these relationships between views with overlay
and background modifiers. For example, if your design includes a graphic that provides contrast behind some text,
you can define a layout so that the graphic adapts its size and position as the text updates. You can
wrap text to fit within the width of another view by defining the text in a background or overlay of that other view.
