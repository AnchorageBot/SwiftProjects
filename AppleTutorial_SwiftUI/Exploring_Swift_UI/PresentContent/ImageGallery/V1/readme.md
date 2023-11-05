1st Draft - Passes photo data from DataModel to its view hierarchy - Modifies the tutorial - Uses Xcode  

How to create this project with Xcode commands:

* Xcode-> File-> New Project -> iOS - App

This creates two files

* ContentView.swift
* ProjectName_App.swift

How to create a View file with keyboard and Xcode commands:

* Command Key (Splat) N -> Swift UI View

How to create a Swift file with keyboard and Xcode commands:

* Command Key (Splat) N -> Swift File

How to create folders to organize app files

* Xcode -> File -> New -> Group

Then just drag and drop the files into the folders that you have created

Main Folder (Group)

* Explore_SwiftUI_V7App.swift
* ContentView.swift
  
AppData Folder (Group)

* DataModel.swift
* Item.swift

AppViews Folder (Group)
* GridItemView.swift
* GridView.swift

- - - -

1st Draft has the following issues:
* Value of type 'FileManager' has no member 'documentDirectory'
* Value of type 'FileManager' has no member 'getContentsOfDirectory'
* Value of type 'FileManager' has no member 'removeItemFromDocumentDirectory'
* Cannot find 'ColumnStepper' in scope
* Cannot find 'DetailView' in scope

1st Draft is missing the following .swift files:
* ColumnStepper.swift
* DetailView.swift
* FileManagerExtensions.swift
* ImageGalleryApp.swift
* PhotoPicker.swift

1st Draft is missing the following .jpg files:
