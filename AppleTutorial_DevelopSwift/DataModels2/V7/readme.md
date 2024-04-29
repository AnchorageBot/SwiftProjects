7th Draft - Following the Apple tutorial

- - - -

Section 6

Add movies using a sheet

Now that you can edit existing movies, it’s time to streamline adding new ones. You can take advantage of the detail view you just created,
presenting it modally in a sheet.

You use a modal interface to focus people on a short, well-defined task. To continue, they must take an action to exit the interface.
Creating a new movie is a great use case. SwiftUI provides several modal interfaces; the best choice for this task is to use a sheet. Sheets
animate from the bottom of the screen, pushing the current view into the background — still visible, but inactive by default.
