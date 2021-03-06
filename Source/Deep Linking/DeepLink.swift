//
//  DeepLink.swift
//  edX
//
//  Created by Salman on 02/10/2018.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit

enum DeepLinkType: String {
    case courseDashboard = "course_dashboard"
    case courseVideos = "course_videos"
    case discussions = "course_discussion"
    case courseDates = "course_dates"
    case courseHandout = "course_handout"
    case courseAnnouncement = "course_announcement"
    case discussionTopic = "discussion_topic"
    case discussionPost = "discussion_post"
    case discussionComment = "discussion_comment"
    case courseDiscovery = "course_discovery"
    case programDiscovery = "program_discovery"
    case programDiscoveryDetail = "program_discovery_detail"
    case degreeDiscovery = "degree_discovery"
    case degreeDiscoveryDetail = "degree_discovery_detail"
    case courseDetail = "course_detail"
    case program = "program"
    case programDetail = "program_detail"
    case account = "account"
    case profile = "profile"
    case none = "none"
}

fileprivate enum DeepLinkKeys: String, RawStringExtractable {
    case CourseId = "course_id"
    case PathID = "path_id"
    case ScreenName = "screen_name"
    case topicID = "topic_id"
    case threadID = "thread_id"
    case commentID = "comment_id"
}

class DeepLink: NSObject {

    let courseId: String?
    let screenName: String?
    let pathID: String?
    let topicID: String?
    let threadID: String?
    let commentID: String?
    var type: DeepLinkType {
        let type = DeepLinkType(rawValue: screenName ?? DeepLinkType.none.rawValue) ?? .none
        if type == .courseDiscovery && courseId != nil {
            return .courseDetail
        }
        else if type == .programDiscovery && pathID != nil {
            return .programDiscoveryDetail
        }
        else if type == .program && pathID != nil {
            return .programDetail
        }
        else if type == .degreeDiscovery && pathID != nil {
            return .degreeDiscoveryDetail
        }
        return type
    }
    
    init(dictionary:[String:Any]) {
        courseId = dictionary[DeepLinkKeys.CourseId] as? String
        screenName = dictionary[DeepLinkKeys.ScreenName] as? String
        pathID = dictionary[DeepLinkKeys.PathID] as? String
        topicID = dictionary[DeepLinkKeys.topicID] as? String
        threadID = dictionary[DeepLinkKeys.threadID] as? String
        commentID = dictionary[DeepLinkKeys.commentID] as? String
    }
}
