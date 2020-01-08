//
//  GistsService.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 6/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import RxSwift
import Alamofire

class GistsAPIService: BaseMappableNetworkRequest<Repository> {
    func getGistsList() -> Observable<[Repository]> {
        return getResponseArray(url: "https://api.github.com/gists/public?since")
    }
    
    func getGistsByUser(username: String) -> Observable<[Repository]> {
        let url: String = "https://api.github.com/users/\(username)/gists?since"
        print("url: \(url)")
        return getResponseArray(url: url)
    }
}
