1st Draft - Following along with the tutorial

- - - -

[1:00 - Create new project](https://youtu.be/fTGA8cjbf5Y?si=bvOBEPL3nXeoL5RS)

Xcode
* Create New Project -> Choose a template for your project -> iOS -> App
* Choose options for your new project:
  * Product Name: RickAndMorty
  * Interface -> Storyboard
  * Language -> Swift

- - - -

[2:35 - Delete Storyboard](https://youtu.be/fTGA8cjbf5Y?si=wh9PSBYHcsM5jrkq)

Xcode
* Project Navigator (Left hand side of screen)
* Click on first file -> Info (center of screen) -> Custom iOS Target Properties
  * Delete main storyboard file
* Custom iOS Target Properties -> Application Scene Manifest -> Scene Configuration
* Scene Configuration -> Window Application Session Role -> Item 0 (Default Configuration)
  * Delete main storyboard file

- - - -

[5:33 - Add & Organize Project Folders](https://youtu.be/fTGA8cjbf5Y?si=qRm9V90iDsd6Np8X)

Xcode
* File -> New -> Folder
* Folders
  * APIClient
  * Controllers
  * Managers
  * Models
  * Resources
  * Views
  * ViewModels
