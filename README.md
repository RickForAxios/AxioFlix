# AxioFlix

## Overview
I decided to take a “text book” approach to building this app. Rather than including fancy extras for things like logging, data persistence, or animation, I opted for clarity brevity.

The one 3rd party library I did use is Kingfisher. Its a great library for loading and caching images, and I’ve found it to be a no-brainer for those that task. Due to that dependency, you will need to run `pod install`.

I used [Paw](https://paw.cloud/) to explore and test the TMDb API and a .paw file is in the repo.

## API
The interface to the TMDb is in `Api.swift`. The API uses the TMDb configuration endpoint for configuring images URLs and it makes sure that it has an up-to-date copy of configuration before fetching movies.

The API layer uses the shared URLSession to fetch data, a simple Codable data model to decode the JSON, and is unconcerned with persistence. It sends the data to persistence via `persistMovies()`.

The API is ready for pagination, but does not paginate due to project scope. You can append new data to the local database by changing `TmdbMoviesPage` and re-running the app. Try page 100 for a movie that does not have a poster or overview.

## Persistence
I used Core Data for local data persistence. I went with the default implementation (which is in the App Delegate). `NSPersistentContainer` makes working with CD much easier than before, but it does require iOS 10.

`NSFetchedResultsController` makes it easy to propagate changes to the UI layer. I’m please with this setup because data can flow from the API to persistence and then show up in the UI with very little coordination or glue code.

I have also used, and like, Realm as a database on iOS. I would normally evaluate Core Data vs. Realm vs. SQLite (with a layer like FMDB on top) based on project needs, team background, and things like anticipated schema churn.

## User Interface
The movies are listed in a TableView. A FetchedResultsController is responsible for loading the data and getting updates. As the TableViewController does a lot, the code is split into several files that cover distinct areas of concern: State, Fetched Results, and the DataSource.
