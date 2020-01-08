//
//  Repository.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import ObjectMapper

public class Repository: Mappable{
    
    required convenience public init?(map: Map) {
      self.init()
    }
    
    private var _url: String?
    private var _forksURL: String?
    private var _commitsURL: String?
    
    private var _id: String?
    private var _nodeID: String?
    private var _gitPullURL: String?
    private var _gitPushURL: String?
    
    private var _htmlURL: String?
    
    private var _welcomePublic: Bool?
    
    private var _createdAt: String?
    private var _updatedAt : [Double]?
    
    private var _description : String?
    private var _comments : Int?
    
    private var _commentsURL : Int?
    private var _truncated : Bool?
    
    private var _owner_image : String?
    private var _owner_name : String?
    
    private var _files: [String : File]?
    private var _owner: Owner?

    public func mapping(map: Map) {
        _url            <- map["url"]
        _forksURL       <- map["forks_url"]
        _commentsURL    <- map["commits_url"]
        
        _id             <- map["id"]
        _nodeID         <- map["node_id"]
        _gitPullURL     <- map["git_pull_url"]
        _gitPushURL     <- map["git_push_url"]
        
        _htmlURL        <- map["html_url"]
        
        _welcomePublic  <- map["public"]
        _createdAt      <- map["created_at"]
        _updatedAt      <- map["updated_at"]
        
        _description    <- map["description"]
        _comments       <- map["comments"]
        
        _commentsURL    <- map["comments_url"]
        _truncated      <- map["truncated"]
        
        _owner_image    <- map["owner.avatar_url"]
        _owner_name     <- map["owner.login"]
        
        _files          <- map["files"]
        _owner          <- map["owner"]
    }
}

extension Repository: HomeViewItemInterface, DetailViewRepositoryInterface {
    var id: String? {
        return _id
    }
    var name: String? {
        return _owner_name
    }
    var url: String? {
        return self._htmlURL;
    }
    var imageUrl: URL? {
        return URL(string: _owner_image!)
    }
    var files: [String : File]? {
        return _files
    }
    var owner: Owner? {
        return _owner
    }
    
    var description: String? {
        return _description
    }
}
