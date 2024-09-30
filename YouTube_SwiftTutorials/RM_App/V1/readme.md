1st Draft - Following along with the tutorial

- - - -

1:00 - Create new project

Xcode
* Create New Project -> Choose a template for your project -> iOS -> App
* Choose options for your new project:
  * Product Name: RickAndMorty
  * Interface -> Storyboard
  * Language -> Swift

- - - -

2:35 - Delete Storyboard

Xcode
* Project Navigator (Left hand side of screen)
* Click on first file -> Info (center of screen) -> Custom iOS Target Properties
  * Delete main storyboard file
* Custom iOS Target Properties -> Application Scene Manifest -> Scene Configuration
* Scene Configuration -> Window Application Session Role -> Item 0 (Default Configuration)
  * Delete main storyboard file

- - - -

5:33 - Add & Organize Project Folders

Xcode
* File -> New -> Folder
* Folders
  * APIClient
  * Controllers
    * Core 
  * Managers
  * Models
  * Resources
  * Views
  * ViewModels

- - - -

9:49 - Add a cocoa touch file

Xcode
* File -> New File From Template -> iOS -> Cocoa Touch Class
  * Class: RMCharacterViewController
  * Subclass of: UIViewController
  * Targets: RickAndMorty

- - - -

Stopped working on tutorial at 11:54
