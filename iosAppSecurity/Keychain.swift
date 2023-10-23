//
//  Keychain.swift
//  iosAppSecurity
//
//  Created by Erbay, Yagiz on 23.10.2023.
//

import Foundation
import UIKit

class KeyChain {
    
    public static let shared = KeyChain()
    
    func save(key: String, data: NSData) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    func load(key: String) -> NSData? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue ?? false,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef:AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if let data = dataTypeRef {
            if status == noErr {
                return (data as? NSData)
            }
        }
        return nil
    }
    
    func stringToNSDATA(string : String)->NSData {
        let _Data = string.data(using: .utf8)!
        return _Data as NSData
        
    }
    
    func NSDATAtoString(data: NSData)->String {
        guard let returned_string = String(data: data as Data, encoding: String.Encoding.utf8) else { return "" }
        return returned_string
    }
}
