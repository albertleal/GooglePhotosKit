//
//  MediaItem.swift
//  GooglePhotosKit
//
//  Created by Guillermo Muntaner Perelló on 12/05/2018.
//  Copyright © 2018 GooglePhotosKit. All rights reserved.
//

import Foundation

typealias Number = Double

/// Representation of a media item (such as a photo or video) in Google Photos.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/mediaItems)
public struct MediaItem: Decodable {
    
    /// Identifier for the media item.
    ///
    /// This is a persistent identifier that can be used between sessions to identify this media item.
    let id: String
    
    /// Description of the media item.
    ///
    /// This is shown to the user in the item's info section in the Google Photos app.
    let description: String
    
    /// Google Photos URL for the media item.
    ///
    /// This link is only available to the user if they're signed in.
    let productUrl: String
    
    /// A URL to the media item's bytes.
    ///
    /// This shouldn't be used as is. For  example, '=w2048-h1024' will set the
    /// dimensions of a media item of type photo to have a width of 2048 px and
    /// height of 1024 px.
    let baseUrl: String
    
    /// MIME type of the media item.
    let mimeType: String
    
    /// Metadata related to the media item, for example the height, width or
    /// creation time.
    let mediaMetadata: MediaMetadata
    
    /// Information about the user who created this media item.
    let contributorInfo: ContributorInfo
    
//    /// Not yet available. Location of the media item.
//    let letlocation: Location
}


public struct MediaMetadata: Decodable {
    
    enum DecodingError: Error {
        case unrecognizedMediaType
    }
    
    /// Union field metadata can be only one of the following:
    enum MediaType {
        case photo(Photo)
        case video(Video)
    }
    
    /// Time when the media item was first created (not when it was uploaded to
    /// Google Photos).
    ///
    /// A timestamp in RFC3339 UTC "Zulu" format, accurate to nanoseconds.
    /// Example: "2014-10-02T15:01:23.045123456Z".
    let creationTime: Date
    
    /// Original width (in pixels) of the media item.
    let width: Int64
    
    /// Original height (in pixels) of the media item.
    let height: Int64
    
    /// Union field metadata, either photo or video
    /// if photo will come within field "photo"
    /// if video will come within field "video"
    let mediaType: MediaType

    // MARK: - Decodable
    
    private enum CodingKeys: String, CodingKey {
        case creationTime, width, height, photo, video
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        creationTime = try container.decode(Date.self, forKey: .creationTime)
        width = try container.decode(Int64.self, forKey: .width)
        height = try container.decode(Int64.self, forKey: .height)
        if let photo = try container.decodeIfPresent(Photo.self, forKey: .photo) {
            mediaType = .photo(photo)
        } else if let video = try container.decodeIfPresent(Video.self, forKey: .video) {
            mediaType = .video(video)
        } else {
            throw DecodingError.unrecognizedMediaType
        }
    }
}

/// Metadata that is specific to a photo, for example, ISO, focal length and
/// exposure time. Some of these fields may be null or not included.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/mediaItems#photo)
public struct Photo: Decodable {
    
    /// Brand of the camera that took the photo.
    let cameraMake: String
    
    /// Model of the camera that took the photo.
    let cameraModel: String
    
    /// Focal length of the photo.
    let focalLength: Number
    
    /// Aperture f number of the photo.
    let apertureFNumber: Number
    
    /// ISO of the photo.
    let isoEquivalent: Number
    
    /// Exposure time of the photo. A duration in seconds with up to nine
    /// fractional digits, terminated by 's'. Example: "3.5s".
    let exposureTime: Duration
}

/// A Duration represents a signed, fixed-length span of time represented as a
/// count of seconds and fractions of seconds at nanosecond resolution. It is
/// independent of any calendar and concepts like "day" or "month". It is
/// related to Timestamp in that the difference between two Timestamp values is
/// a Duration and it can be added or subtracted from a Timestamp. Range is
/// approximately +-10,000 years.
///
/// [Documentation](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Duration)
public struct Duration: Decodable {
    
    /// Signed seconds of the span of time. Must be from -315,576,000,000 to
    /// +315,576,000,000 inclusive.
    let seconds: Int64
    
    /// Signed fractions of a second at nanosecond resolution of the span of
    /// time. Durations less than one second are represented with a 0 seconds
    /// field and a positive or negative nanos field. For durations of one
    /// second or more, a non-zero value for the nanos field must be of the same
    /// sign as the seconds field. Must be from -999,999,999 to +999,999,999
    /// inclusive.
    let nanos: Int32
}

/// Processing status of a video being uploaded to Google Photos.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/mediaItems#video)
public struct Video: Decodable {
    
    /// Brand of the camera that took the video.
    let cameraMake: String
    
    /// Model of the camera that took the video.
    let cameraModel: String
    
    /// Frame rate of the video.
    let fps: Number
    
    /// Processing status of the video.
    let status: VideoProcessingStatus
}

/// Processing status of a video being uploaded to Google Photos.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/mediaItems#videoprocessingstatus)
public enum VideoProcessingStatus: String, Decodable {
    
    /// Video processing status is unknown.
    case unspecified = "UNSPECIFIED"
    
    /// Video is being processed. The user sees an icon for this video in the Google Photos app, however, but it isn't playable yet.
    case processing = "PROCESSING"
    
    /// Video is now ready for viewing.
    case ready = "READY"
    
    /// Something has gone wrong and the video has failed to process.
    case failed = "FAILED"
}

/// Information about a user who contributed the media item. Note that this
/// information is only included if the album containing the media item is
/// shared, was created by you and you have the sharing scope.
///
/// [Documentation](https://developers.google.com/photos/library/reference/rest/v1/mediaItems#contributorinfo)
public struct ContributorInfo: Decodable {
    
    /// URL to the profile picture of the contributor.
    let profilePictureBaseUrl: String
    
    /// Display name of the contributor.
    let displayName: String
}
