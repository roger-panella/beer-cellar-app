//
//  NotificationCenterExtensions.swift
//  Blubbr
//
//  Created by Ben Munge on 5/21/17.
//  Copyright © 2017 Blubbr App. All rights reserved.
//

import Foundation

enum NotificationKey: String {
    case untappdAuthorizationSuccessful
    case untappdAuthorizationFailed
}

extension NotificationCenter {
    func post(key aKey: NotificationKey) {
        post(name: NSNotification.Name(rawValue: aKey.rawValue), object: nil)
    }
    
    func addObserver(_ observer: Any, selector aSelector: Selector, key aKey: NotificationKey, object anObject: Any?) {
        let name = NSNotification.Name(rawValue: aKey.rawValue)
        addObserver(observer, selector: aSelector, name: name, object: anObject)
    }
}
