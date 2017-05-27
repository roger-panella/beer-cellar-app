//
//  BeerSearchResponse.swift
//  Blubbr
//
//  Created by Roger Panella on 5/26/17.
//  Copyright © 2017 Blubbr App. All rights reserved.
//

import Foundation
import Unbox

public struct BeerSearchResponse {
    
    public let beers: [Beer]
    
    public init(beers: [Beer]) {
        self.beers = beers
    }
}

extension BeerSearchResponse: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.beers = try unboxer.unbox(keyPath: "response.beers.items")
    }
}
