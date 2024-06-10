# MovieDB

MovieDB_Kushagra is an iOS application built in Swift using UIKit and it uses [NetworkingSDK](https://github.com/kushagrauchiha/NetworkingSDK) to handle `GET` operations for Latest, Popular and MovieDetails.

## Functioning

The Application has a tab bar which
- Display a list of Now Playing movies.
- Display a list of Popular movies.

It leverages UICollectionViewController to display list of movies. Now clicking on a movie will fetch from MovieDetailsAPI which will detail view for each movie with additional information.
