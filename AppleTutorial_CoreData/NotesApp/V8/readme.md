A toy note taking app

- - - -

Tutor: Anthropic's AI Claude

[Apple Design](https://developer.apple.com/design/)

[Apple Design Pathway](https://developer.apple.com/design/pathway/)

- - - -

8th Draft - Customizes app testing

- - - -

To get the NotesAppV1Tests.swift file working:

1. Create a new unit test target:
   - In Xcode, go to File > New > Target
   - Choose "Unit Testing Bundle" under iOS
   - Name it "NotesAppV1Tests"

2. Ensure the test file is in the correct target:
   - Click on "NotesAppV1Tests.swift" in the project navigator
   - In the File Inspector, under "Target Membership", check only "NotesAppV1Tests"

3. Add necessary imports to the test file:
   ```swift
   import XCTest
   import CoreData
   @testable import NotesAppV1
   ```

4. Check for and remove duplicate test files:
   - Look in the NotesAppV1Tests folder for any duplicate NotesAppV1Tests.swift files
   - Delete any duplicates, keeping only one NotesAppV1Tests.swift file

5. Clean and rebuild:
   - Go to Product > Clean Build Folder
   - Build the project again
