2nd Draft

Reviewed the project download files and noted that the following files were not shown/listed on the tutorial:
* ColorOption
* EventDetail
* EventRow
* EventSymbols
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
* ColorOption.swift
* Event.swift
* EventData.swift
* EventSymbols.swift
* EventTask.swift

AppViews Folder (Group)
* DatePlannerApp.swift
* EventDetail.swift
* EventList.swift
* EventRow.swift
* SFSymbolStyling.swift
* SymbolPicker.swift
* TaskRow.swift
- - - - 

TaskRow.swift

Failed to build the scheme error

'onChange(of:perform:)' was deprecated in iOS 17.0: Use `onChange` with a two or zero parameter action closure instead.

- - - - 

Consider downloading and installing the [Apple SF Symbols App](https://developer.apple.com/sf-symbols/)

* When using the SF Symbols app you can right-click any symbol and choose Copy Name
* UI Kit code sample

        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)

* Swift UI code sample

       // Symbol effects in SwiftUI

        Image(systemName: "wifi.router")
            .symbolEffect(.variableColor.iterative.reversing)
            .symbolEffect(.scale.up)
  
* WWDC21 Video [Explore the SF Symbols 3 app](https://developer.apple.com/videos/play/wwdc2021/10288/)
* WWDC22 Video [What's new in SF Symbols 4](https://developer.apple.com/videos/play/wwdc2022/10157)
* WWDC23 Video [What’s new in SF Symbols 5](https://developer.apple.com/videos/play/wwdc2023/10197)
* WWDC23 Video [ Animate symbols in your app](https://developer.apple.com/videos/play/wwdc2023/10258)

- - - -

Consider downloading and installing the [Apple TestFlight App](https://developer.apple.com/testflight/)

* Beta Testing made simple with TestFlight
