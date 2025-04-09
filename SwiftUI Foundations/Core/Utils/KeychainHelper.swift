// Core/Utilities/KeychainHelper.swift
import Foundation
import Security

protocol KeychainHelperProtocol {
    func save(_ data: Data, service: String, account: String) throws
    func read(service: String, account: String) throws -> Data?
    func delete(service: String, account: String) throws
}

final class KeychainHelper: KeychainHelperProtocol {
    static let shared = KeychainHelper()
    private init() {}
    
    func save(_ data: Data, service: String, account: String) throws {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func read(service: String, account: String) throws -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
        
        return result as? Data
    }
    
    func delete(service: String, account: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    enum KeychainError: Error {
        case unexpectedStatus(OSStatus)
    }
}
