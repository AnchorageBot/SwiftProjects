App with a button and repaired memory leak

- - - -

Claude:

By making the vc property of MyView a weak reference, we break the retain cycle between MyView and SecondVC. Now, when SecondVC is dismissed and no longer needed, it will be deallocated properly because there are no strong references keeping it alive. The deinit method in SecondVC will be called when the instance is deallocated, indicating that the memory leak has been fixed.
With these changes, the memory leak is resolved, and the SecondVC instance will be properly deallocated when it's no longer needed.

- - - -

[Claude - Anthropic](https://www.anthropic.com)

- - - -

How to create this project with Xcode commands:

* Xcode-> File-> New Project -> iOS - App
* Interface -> Storyboard

This creates the following files:

* AppDelegate.swift
* SceneDelegate.swift
* ViewController.swift

- - - -
