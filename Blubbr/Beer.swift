//
//  Beer.swift
//  Blubbr
//
//  Created by Roger Panella on 5/27/17.
//  Copyright © 2017 Blubbr App. All rights reserved.
//

import Unbox

public struct Beer {
    public let name: String
    public let brewery: String
    public let imageURL: String
    public let style: String
    
    
    public init(name: String,
                brewery: String,
                imageURL: String,
                style: String) {
        self.name = name
        self.brewery = brewery
        self.imageURL = imageURL
        self.style = style
    }
}

extension Beer: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(keyPath: "beer.beer_name")
        self.brewery = try unboxer.unbox(keyPath: "brewery.brewery_name")
        self.imageURL = try unboxer.unbox(keyPath: "beer.beer_label")
        self.style = try unboxer.unbox(keyPath: "beer.beer_style")
    }
}
