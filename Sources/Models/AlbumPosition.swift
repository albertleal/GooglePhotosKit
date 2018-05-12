//
//  AlbumPosition.swift
//  GooglePhotosKit
//
//  Created by Guillermo Muntaner Perelló on 12/05/2018.
//  Copyright © 2018 GooglePhotosKit. All rights reserved.
//

import Foundation

/// Specifies a position in an album.
/// Type of position, for a media or enrichment item
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/AlbumPosition)
public enum AlbumPosition: Encodable {
    
    /// Default value if this enum isn't set.
    case positionTypeUnspecified
    
    /// At the beginning of the album.
    case firstInAlbum
    
    /// At the end of the album.
    case lastInAlbum
    
    /// After a media item.
    ///
    /// - Associated value relativeMediaItemId: The media item to which the
    /// position is relative to.
    case afterMediaItem(relativeMediaItemId: String)
    
    /// After an enrichment item.
    ///
    /// - Associated value relativeEnrichmentItemId: The enrichment item to
    /// which the position is relative to.
    case afterEnrichmentItem(relativeEnrichmentItemId: String)
    
    // MARK: - Encodable
    
    private enum CodingKeys: String, CodingKey {
        case position, relativeMediaItemId, relativeEnrichmentItemId
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .positionTypeUnspecified:
            try container.encode("POSITION_TYPE_UNSPECIFIED", forKey: .position)
        case .firstInAlbum:
            try container.encode("FIRST_IN_ALBUM", forKey: .position)
        case .lastInAlbum:
            try container.encode("LAST_IN_ALBUM", forKey: .position)
        case .afterMediaItem(let relativeMediaItemId):
            try container.encode("AFTER_MEDIA_ITEM", forKey: .position)
            try container.encode(relativeMediaItemId, forKey: .relativeMediaItemId)
        case .afterEnrichmentItem(let relativeEnrichmentItemId):
            try container.encode(relativeEnrichmentItemId, forKey: .relativeEnrichmentItemId)
        }
    }
}
