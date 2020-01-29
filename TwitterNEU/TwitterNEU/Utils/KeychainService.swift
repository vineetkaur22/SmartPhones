//
//  KeychainService.swift
//  TwitterNEU

import Foundation
import KeychainSwift

class KeyChainService{
    var _keyChain = KeychainSwift()
    var keyChain: KeychainSwift{
        get{
            return _keyChain
        }
        set{
            _keyChain = newValue
        }
    }
}

