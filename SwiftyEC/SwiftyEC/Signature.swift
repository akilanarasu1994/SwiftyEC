//
//  Signature.swift
//  SwiftyEC
//
//  Created by Akilan Thirunavukka Arasu on 26/06/17.
//  Copyright © 2017 Akilan Thirunavukka Arasu. All rights reserved.
//

import Foundation

public class Signature {
    
    public enum DigestType {
        case sha1
        case sha224
        case sha256
        case sha384
        case sha512
        
        var padding: Padding {
            switch self {
            case .sha1: return .PKCS1SHA1
            case .sha224: return .PKCS1SHA224
            case .sha256: return .PKCS1SHA256
            case .sha384: return .PKCS1SHA384
            case .sha512: return .PKCS1SHA512
            }
        }
    }
    
    /// Data of the signature
    public let data: Data
    
    /// Creates a signature with data.
    ///
    /// - Parameter data: Data of the signature
    public init(data: Data) {
        self.data = data
    }
    
    /// Creates a signature with a base64-encoded string.
    ///
    /// - Parameter base64String: Base64-encoded representation of the signature data.
    /// - Throws: SwiftyECError
    public convenience init(base64Encoded base64String: String) throws {
        guard let data = Data(base64Encoded: base64String) else {
            throw SwiftyECError.invalidBase64String
        }
        self.init(data: data)
    }
    
    /// Returns the base64 representation of the signature.
    public var base64String: String {
        return data.base64EncodedString()
    }
}
