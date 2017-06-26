//
//  PrivateKey.swift
//  SwiftyEC
//
//  Created by Akilan Thirunavukka Arasu on 26/06/17.
//  Copyright © 2017 Akilan Thirunavukka Arasu. All rights reserved.
//

import Foundation

public class PrivateKey: Key {
    
    /// Reference to the key within the keychain
    public let reference: SecKey
    
    /// Original data of the private key.
    /// Note that it does not contain PEM headers and holds data as bytes, not as a base 64 string.
    public let originalData: Data?
    
    let tag: String?
    
    /// Returns a PEM representation of the private key.
    ///
    /// - Returns: Data of the key, PEM-encoded
    /// - Throws: SwiftyECError
    public func pemString() throws -> String {
        let data = try self.data()
        let pem = SwiftyEC.format(keyData: data, withPemType: "EC PRIVATE KEY")
        return pem
    }
    
    /// Creates a private key with a keychain key reference.
    /// This initializer will throw if the provided key reference is not a private EC key.
    ///
    /// - Parameter reference: Reference to the key within the keychain.
    /// - Throws: SwiftyECError
    public required init(reference: SecKey) throws {
        
        guard SwiftyEC.isValidKeyReference(reference, forClass: kSecAttrKeyClassPrivate) else {
            throw SwiftyECError.notAPrivateKey
        }
        
        self.reference = reference
        self.tag = nil
        self.originalData = nil
    }
    
    /// Creates a private key with a EC public key data.
    ///
    /// - Parameter data: Private key data
    /// - Throws: SwiftyECError
    required public init(data: Data) throws {
        self.originalData = data
        let tag = UUID().uuidString
        print("SwiftyEC: tag: ", tag)
        self.tag = tag
        let dataWithoutHeader = try SwiftyEC.stripKeyHeader(keyData: data)
        print("dataWithoutHeader: ", dataWithoutHeader.base64EncodedString())
        reference = try SwiftyEC.addKey(dataWithoutHeader, isPublic: false, tag: tag)
    }
    
    deinit {
        if let tag = tag {
            SwiftyEC.removeKey(tag: tag)
        }
    }
}
