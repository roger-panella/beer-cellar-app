//
//  UserDefaultsExtensions.swift
//  Blubbr
//
//  Created by Ben Munge on 5/21/17.
//  Copyright © 2017 Blubbr App. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case accessToken
}

extension UserDefaults {
    
    func setValue(_ value: Any?, forKey key: UserDefaultsKey) {
        set(value, forKey: key.rawValue)
    }
    
    func value(forKey key: UserDefaultsKey) -> Any? {
        return value(forKey: key.rawValue)
    }
}
