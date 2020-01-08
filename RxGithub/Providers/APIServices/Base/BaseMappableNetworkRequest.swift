//
//  BaseMappableNetworkRequest.swift
//  RxGithub
//
//  Created by Wing Chiu.C on 7/1/2020.
//  Copyright © 2020 Wing Chiu.C. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper
import AlamofireObjectMapper

class BaseMappableNetworkRequest<T: Mappable>: BaseNetworkRequest{
    
    public override init() {
        super.init()
    }
    
    public func getResponseArray(url: String) -> Observable<[T]>{
        let urlStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStr!)
        let alamofireRequest = RxAlamofire.request(getMethodType(),
                                                   url!,
                                                   parameters: getParameters(),
                                                   headers: getHeaders())
        
        let observable = alamofireRequest.flatMap{
            $0.rx_responseArray(type: T.self)
        }
        return observable
    }
    
    public func getResponseObject(url: String) -> Observable<T>{
        let urlStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStr!)
        let alamofireRequest = RxAlamofire.request(getMethodType(),
                                                   url!,
                                                   parameters: getParameters(),
                                                   encoding: getEncoding(),
                                                   headers: getHeaders())
        
        let observable = alamofireRequest.flatMap{
            $0.rx_responseObject(type: T.self)
        }
        return observable
    }
    
}
