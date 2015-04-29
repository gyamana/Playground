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
        var inputCount = count(input)
        
        if inputCount % 2 == 0 {
            for var i = 0; i < inputCount; i += 2 {
                var hexString: String = ""
                hexString.append(charArray[i])
                hexString.append(charArray[i + 1])
                let num = UInt8(strtoul(hexString, nil, 16))
                intArray.append(num)
            }
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
        if(encryptedHexString == "" || keyString == "" || encryptedHexString.rangeOfString(":") == nil) {
            return ""
        }
        
        //Expected `encryptedHexString` format to be iv:encrypted, so split the string on the colon.
        let ivAndEncrypted = split(encryptedHexString) {
            $0 == ":"
        }
        
        //128 bit initialization vector
        let ivBytes = hexByteStringToByteArray(ivAndEncrypted[0])
        
        //Initialization vector must be 128 bits or 16 bytes in length
        if ivBytes.count == 0 || ivBytes.count != 16 {
            println("ivBytes is not 16 bytes long")
            return ""
        }
        
        let encryptedBytes = hexByteStringToByteArray(ivAndEncrypted[1])
        
        //`encryptedBytes` must be of length in multiples of 128 bits, or 16 bytes.
        if encryptedBytes.count == 0 || encryptedBytes.count % 16 != 0 {
            println("encryptedBytes is not a multiple of 16 bytes")
            return ""
        }
        
        //Take a plain string, apply a SHA-256 hash to it to get a NSData object of just the right size - 256 bits
        let keyData = (keyString as NSString).dataUsingEncoding(NSUTF8StringEncoding)?.sha256()
        let count = keyData!.length / sizeof(UInt8)
        
        //Converty key into [UInt8 format as expected by CryptoSwift
        var keyBytes = [UInt8](count: count, repeatedValue: 0)

        //`keyBytes` must be 256 bits or 32 bytes in length
        if keyBytes.count == 0 || keyBytes.count != 32 {
            println("keyBytes is not 32 bytes long")
            return ""
        }
        
        keyData!.getBytes(&keyBytes, length:count * sizeof(UInt8))

        //Encryption/decryption to be in AES, 128 bit, in Cipher Block Chaining mode
        //Issue experienced when using the in-built padding class, replace with PKCS7Custom to 
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

/*
  Cut and past from PKCS7() from CryptoSwift as there seems to be an issue reading the last byte, as documented with:
  https://github.com/krzyzanowskim/CryptoSwift/issues/57
*/
public struct PKCS7Custom: Padding {
    
    public init() {
        
    }
    
    public func add(bytes: [UInt8] , blockSize:Int) -> [UInt8] {
        var padding = UInt8(blockSize - (bytes.count % blockSize))
        var withPadding = bytes
        if (padding == 0) {
            // If the original data is a multiple of N bytes, then an extra block of bytes with value N is added.
            for i in 0..<blockSize {
                withPadding.extend([UInt8(blockSize)])
            }
        } else {
            // The value of each added byte is the number of bytes that are added
            for i in 0..<padding {
                withPadding.extend([UInt8(padding)])
            }
        }
        return withPadding
    }
    
    public func remove(bytes: [UInt8], blockSize:Int? = nil) -> [UInt8] {
        var lastByte = bytes.last
        var padding = Int(lastByte!) // last byte
        
        if padding >= 1 { //TODO: need test for that, what about empty padding
            return Array(bytes[0..<(bytes.count - padding)])
        }
        return bytes
    }
}