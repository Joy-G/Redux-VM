//
//  KeychainService.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//


import UIKit
import os.log

enum KeychainService {
    /// Save password item in keychain.
    /// Returns true if item is saved in keychain, else returns false.
    /// - Parameter item: Password item which has to be saved in keychain.
    /// - Parameter service: Service for which the keychain should be initialised with.
    /// - Parameter account: Account for which the password should be saved against.
    static func savePasswordItem(item: String, forService service: String, withAccount account: String) -> Bool {
        let passwordItem = KeychainPasswordItem(service: service, account: account)
        do {
            try passwordItem.savePassword(item)
            return true
        } catch {
            os_log(.error, log: .keychainAccess, "Error saving password item in keychain - %@", "\(error)")
            return false
        }
    }
    /// Returns saved password item from keychain.
    /// - Parameter service: Service for which the keychain should be initialised with.
    /// - Parameter account: Account from which the password should be fetched.
    static func getPasswordItem(forService service: String, withAccount account: String) -> String? {
        let passwordItem = KeychainPasswordItem(service: service, account: account)
        do {
            let passwordString = try passwordItem.readPassword()
            return passwordString
        } catch {
            os_log(.error, log: .keychainAccess, "Error fetching password item from keychain - %@", "\(error)")
            return nil
        }
    }
    /// Deletes password item from keychain.
    /// - Parameter service: Service for which the keychain should be initialised with.
    /// - Parameter account: Account for which the password should be deleted.
    static func deletePasswordItem(forService service: String, withAccount account: String) {
        let passwordItem = KeychainPasswordItem(service: service, account: account)
        do {
            try passwordItem.deleteItem()
        } catch {
            os_log(.error, log: .keychainAccess, "Error deleting password item from keychain - %@", "\(error)")
        }
    }
}
