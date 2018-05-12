//
//  Album.swift
//  GooglePhotosKit
//
//  Created by Guillermo Muntaner Perelló on 12/05/2018.
//  Copyright © 2018 GooglePhotosKit. All rights reserved.
//

/// Representation of an album in Google Photos. Albums are a container for
/// media items. If an album has been shared by the application, it contains an
/// extra shareInfo property.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/albums)
public struct Album: Decodable {
    
    /// [Ouput only] Identifier for the album. This is a persistent identifier
    /// that can be used between sessions to identify this album.
    let id: String
    
    /// Name of the album displayed to the user in their Google Photos account.
    /// This string shouldn't be more than 500 characters.
    let title: String
    
    /// [Output only] Google Photos URL for the album. The user needs to be
    /// signed in to their Google Photos account to access this link.
    let productUrl: String
    
    /// [Output only] True if you can create media items in this album. This
    /// field is based on the scopes granted and permissions of the album. If
    /// the scopes are changed or permissions of the album are changed, this
    /// field is updated.
    let isWriteable: String
    
    /// [Output only] Information related to shared albums. This field is only
    /// populated if the album is a shared album, the developer created the
    /// album and the user has granted the photoslibrary.sharing scope.
    let shareInfo: ShareInfo
    
    /// [Output only] The number of media items in the album.
    let totalMediaItems: Int64
    
    /// [Output only] A URL to the cover photo's bytes. This shouldn't be used
    /// as is. Parameters should be appended to this URL before use. For
    /// example, '=w2048-h1024' sets the dimensions of the cover photo to have
    /// a width of 2048 px and height of 1024 px.
    let coverPhotoBaseUrl: String
    
}

/// Information about albums that are shared. This information is only included
/// if you created the album, it is shared and you have the sharing scope.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/albums#shareinfo)
public struct ShareInfo: Decodable {
    
    /// Options that control the sharing of an album.
    let sharedAlbumOptions: SharedAlbumOptions
    
    /// A link to the album that's now shared on the Google Photos website and
    /// app. Anyone with the link can access this shared album and see all of
    /// the items present in the album
    let shareableUrl: String
    
    /// A token that can be used to join this shared album on behalf of other
    /// users via the API.
    let shareToken: String
}

/// Options that control the sharing of an album.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/albums#sharedalbumoptions)
public struct SharedAlbumOptions: Decodable {
    
    /// True if the shared album allows collaborators (users who have joined the
    /// album) to add media items to it. Defaults to false.
    let isCollaborative: Bool
    
    /// True if the shared album allows the owner and the collaborators (users
    /// who have joined the album) to add comments to the album. Defaults to
    /// false.
    let isCommentable: Bool
}
