//
//  Owner.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import ObjectMapper

public class Owner: Mappable {
    
    required convenience public init?(map: Map) {
        self.init()
        _id <- map["id"]
    }
    
    private var _id: String?
    private var _type: String?
    
    private var _login: String?
    private var _nodeId: String?
    private var _avatarURL: String?
    private var _gravatarID: String?
    private var _url: String?
    private var _htmlURL: String?
    private var _followersURL: String?
    private var _followingURL: String?
    private var _gistsURL: String?
    private var _starredURL: String?
    private var _subscriptionsURL: String?
    private var _organizationsURL: String?
    
    private var _reposURL: String?
    private var _eventsURL: String?
    private var _receivedEventsURL: String?
    private var _siteAdmin: String?
    
    public func mapping(map: Map) {
        _id                 <- map["id"]
        _type               <- map["type"]
        _login              <- map["login"]
        _nodeId             <- map["node_id"]
        _avatarURL          <- map["avatar_url"]
        _gravatarID         <- map["gravatar_id"]
        _url                <- map["url"]
        _htmlURL            <- map["html_url"]
        _followersURL       <- map["followers_url"]
        _followingURL       <- map["following_url"]
        _gistsURL           <- map["gists_url"]
        _starredURL         <- map["starred_url"]
        _subscriptionsURL   <- map["subscriptions_url"]
        _organizationsURL   <- map["organizations_url"]
        _reposURL           <- map["repos_url"]
        _eventsURL          <- map["events_url"]
        _receivedEventsURL  <- map["received_events_url"]
        _siteAdmin          <- map["site_admin"]
    }
}

extension Owner: DetailViewOwnerItemInterface {
    var name: String? {
        return _login
    }
    
    var url: String? {
        return _url
    }
    
    var htmlURL: String? {
        return _htmlURL
    }
    
    var imageUrl: URL? {
        return URL(string: _avatarURL!)
    }
}
