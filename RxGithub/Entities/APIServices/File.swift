//
//  File.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 5/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import ObjectMapper

public class File : Mappable{
    required convenience public init?(map: Map) {
      self.init()
    }
    
    private var _filename: String?
    private var _language: String?
    private var _type: String?

    private var _rawURL: String?
    private var _size: Int?
    
    public func mapping(map: Map) {
        _filename       <- map["filename"]
        _language       <- map["language"]
        _type           <- map["type"]
        _size           <- map["size"]
        _rawURL         <- map["rawURL"]
   }
}
