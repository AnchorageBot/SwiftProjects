4th Draft - Following the Apple tutorial

- - - -

Section 3

Use a class to provide sample data

You can add new movies in the ContentView preview, but each time you edit the view code, the preview reloads and the items disappear.
That’s because the preview is using a ModelContainer with no persistence. When the preview reloads, it re-creates its model container
with a fresh, empty set of data.

In this section, you’ll create permanent sample data that doesn’t interfere with the persisted data store. All your previews will use
this data so you can see your changes.
