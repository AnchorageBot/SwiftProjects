2nd Draft - app builds - needs design work, needs unit tests

Haven't started the tutorial yet

- - - -

Error message:

"Logging Error: Failed to initialize logging system. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables."

This error is not directly related to your app's code. It's an Xcode logging issue. To resolve this:

* In Xcode, go to your scheme (Product > Scheme > Edit Scheme)
* Select "Run" in the left sidebar
* Go to the "Arguments" tab
* In the "Environment Variables" section, add a new variable:
* Name: IDEPreferLogStreaming
* Value: YES

- - - -

Create Glossary (GV2.md) and Code Pattern (CPV2.md) files in Xcode 

* File -> iOS -> Documentation -> Empty
