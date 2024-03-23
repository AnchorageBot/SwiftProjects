Using Xcode Instruments to debug a memory leak

- - - -

[Memory Leaks in iOS: Find, Diagnose, & Fix (2022) - iOS Academy](https://youtu.be/b2AgibUg47k?si=s-BGr0OsS9vSUHb7)

How to debug with Xcode
* Splat (command), space bar
* Type in "instruments" and hit return

- - - -

Getting started with instruments - WWDC19

- - - -

Track down hangs with Xcode and on device detection - WWDC22

- - - -

[How to analyze hangs with instruments - WWDC23](https://developer.apple.com/videos/play/wwdc2023/10248/)
* Event handling and rendering loop
* Busy main thread hang
* Async hang
* Blocked main thread hang

To open instruments
* Product menu -> profile
* Time Profiler template (first pass/analysis)
  
- - - -

[Lazy Stack Views - Apple Dev Documentation](https://developer.apple.com/documentation/swiftui/grouping-data-with-lazy-stack-views#)
* These stacks are “lazy” in that the stack views don’t create items until they need to be rendered onscreen
* Can be used to reduce hang times
 ** 100 ms
 * 250 ms
 * 500 ms 

- - - -

[Claude - Anthropic](https://www.anthropic.com)
