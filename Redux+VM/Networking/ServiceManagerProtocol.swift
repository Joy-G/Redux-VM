//
//  ServiceManagerProtocol.swift
//  Redux+VM
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

protocol ServiceManagerProtocol {
    func fetchArticle(completion: @escaping(News?, Error?)->())
}
