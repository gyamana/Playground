//
//  Decrypt.swift
//  Playground
//
//  Created by George Yamana on 23/04/2015.
//  Copyright (c) 2015 localz. All rights reserved.
//

import CryptoSwift
import Foundation

public class Decrypt: NSObject {
    
    /*
      Helper method to convert a string of hexadecimal representations of bytes, back to an array of bytes.
    */
    static func hexByteStringToByteArray(input: String) -> [UInt8] {
        let charArray = Array(input)
        
        var intArray = [UInt8]()
        
        for var i = 0; i < count(input); i += 2 {
            var hexString: String = ""
            hexString.append(charArray[i])
            hexString.append(charArray[i + 1])
            let num = UInt8(strtoul(hexString, nil, 16))
            intArray.append(num)
        }
        
        return intArray
    }
    
    /*
      Wrapper around CryptoSwift.decrypt to take in expected input format in String, and output in String rather
      than the raw bytes.
    
      Possible error scenarios to handle:
      Input string format
    */
    static func decryptHexString(encryptedHexString: String, keyString: String) -> String {
        
        if (encryptedHexString.rangeOfString(":") == nil) {
            assert(false, "Invalid format for encryptedHexString")
            return ""
        }
        
        //Expected `encryptedHexString` format to be iv:encrypted, so split the string on the colon.
        let ivAndEncrypted = split(encryptedHexString) {
            $0 == ":"
        }
        
        //128 bit initialization vector
        let ivBytes = hexByteStringToByteArray(ivAndEncrypted[0])
        
        //`encryptedBytes` must be of length in multiples of 128 bits. If this is not met, an empty string will be returned
        //by this function
        let encryptedBytes = hexByteStringToByteArray(ivAndEncrypted[1])
        
        //Take a plain string, apply a SHA-256 hash to it to get a NSData object of just the right size - 256 bits
        let keyData = (keyString as NSString).dataUsingEncoding(NSUTF8StringEncoding)?.sha256()
        let count = keyData!.length / sizeof(UInt8)
        //Converty key into [UInt8 format as expected by CryptoSwift
        var keyBytes = [UInt8](count: count, repeatedValue: 0)
        keyData!.getBytes(&keyBytes, length:count * sizeof(UInt8))

        //Encryption/decryption to be in AES, 128 bit, in Cipher Block Chaining mode
        let decrypted = AES(key: keyBytes, iv: ivBytes, blockMode: CipherBlockMode.CBC)?.decrypt(encryptedBytes, padding: PKCS7())
        
        var result = ""
        
        //Decryption result is in a ASCII code array, so convert it back to characters, will return garbled message without error
        //if either key or iv was incorrect.
        for asciiCode in decrypted! {
            result.append(UnicodeScalar(asciiCode))
        }
        
        return result
    }

}