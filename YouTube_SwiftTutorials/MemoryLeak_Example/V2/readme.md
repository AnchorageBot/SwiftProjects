App with a button and memory leak - with comments

- - - -

Claude:

The memory leak in this code occurs because the MyView instance holds a strong reference to the SecondVC instance through the vc property, and the SecondVC instance holds a strong reference to the MyView instance through the myView property. This creates a retain cycle, where both instances keep each other alive even after the SecondVC is dismissed. To fix the memory leak, one of the references should be made weak or unowned to break the retain cycle.

- - - -

How to create this project with Xcode commands:

* Xcode-> File-> New Project -> iOS - App
* Interface -> Storyboard

This creates the following files:

* AppDelegate.swift
* SceneDelegate.swift
* ViewController.swift

- - - -
