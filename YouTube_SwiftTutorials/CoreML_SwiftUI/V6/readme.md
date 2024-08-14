6th Draft - Still chasing a bug

Errors:
* Sorry, there was a problem calculating a VIX estimate: Predicted feature 'EstVix' was not output by pipeline
* Prediction Error
  * The operation couldn't be completed. (VixRefresh.VixPredictionError error 1)

Xcode debugging methods
* Finder Menu -> Go -> Library -> Developer -> Xcode -> DerivedData (move this folder to the trashcan & empty the trashcan)
* Xcode Menu -> Product -> Clean Build Folder
* Xcode Menu -> Product -> Build

- - - -

Vix Index Prediction app

Tutor:

Anthropic's AI Claude

- - - -

Drag a copy of Vix2407Auto.mlmodel (Made with Apple's Create ML App) into Xcode and drop it next to the VixPredictionModel.swift file in the project navigator pane on the left of the screen

- - - -

Uses files (included):
* Vix2407CSV.csv
* Vix2407Auto.mlmodel
