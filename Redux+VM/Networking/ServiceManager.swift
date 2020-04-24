//
//  ServiceManager.swift
//  Redux+VM
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import Alamofire

class ServiceManager {
    static let sharedInstance = ServiceManager()
}

extension ServiceManager: ServiceManagerProtocol {

    func fetchArticle(completion: @escaping (News?, Error?) -> ()) {
        AF.request(APIEndpoint.news)
        .responseDecodable(of: News.self, decoder: newJSONDecoder()) { response in
            completion(response.value, response.error)
        }
    }

}
