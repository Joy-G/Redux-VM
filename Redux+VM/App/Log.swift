//
//  Log.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let app = OSLog(subsystem: subsystem, category: "App")
    static let gui = OSLog(subsystem: subsystem, category: "Gui")
    static let keychainAccess = OSLog(subsystem: subsystem, category: "Keychain")
    static let store = OSLog(subsystem: subsystem, category: "Store")
    static let login = OSLog(subsystem: subsystem, category: "Login")
    static let signup = OSLog(subsystem: subsystem, category: "SignUp")
    static let dashboard = OSLog(subsystem: subsystem, category: "Dashboard")
    static let forgotPassword = OSLog(subsystem: subsystem, category: "ForgotPassword")
}
