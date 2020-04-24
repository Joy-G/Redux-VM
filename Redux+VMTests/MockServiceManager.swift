//
//  MockServiceManager.swift
//  Redux+VMTests
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
@testable import Redux_VM

class MockServiceManager {
    enum MockServiceError: Error {
        case downloadError
    }
}

extension MockServiceManager: ServiceManagerProtocol {
    func fetchArticle(completion: @escaping (News?, Error?) -> ()) {
        let path = Bundle.main.path(forResource: "News", ofType: "json", inDirectory: nil)
        if let filePath = path {
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
            completion(try? News(data: data), nil)
        } else {
            completion(nil, MockServiceError.downloadError)
        }
    }
}
