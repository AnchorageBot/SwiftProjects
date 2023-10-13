2nd Draft

Reviewed the project download files and noted that the following files were not shown/listed on the tutorial:
* ColorOption
* EventDetail
* EventRow
* EventSymbols
* EventTask
* SFSymbolStyling
* SymbolPicker
* TaskRow

- - - -

Draft V1 consisted of the following tutorial files:

Main Folder (Group)
* Explore_SwiftUI_V4App.swift
* ContentView.swift

AppData Folder (Group)
* Event.swift
* EventData.swift
* EventTask.swift

AppViews Folder (Group)
* DatePlannerApp.swift
* EventList.swift

- - - - 

Draft V2 combines draft V1 and the project download files and arranges them as follows:

Main Folder (Group)
* Explore_SwiftUI_V4App.swift
* ContentView.swift

AppData Folder (Group)
* ColorOption
* Event.swift
* EventData.swift
* EventSymbols
* EventTask.swift

AppViews Folder (Group)

- - - - 

Consider downloading the [Apple SF Symbols App](https://developer.apple.com/sf-symbols/) and installing it

* When using the SF Symbols app you can right-click any symbol and choose Copy Name
* UI Kit code sample

        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)
