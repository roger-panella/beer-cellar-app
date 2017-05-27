//
//  BeerSearchService.swift
//  Blubbr
//
//  Created by Roger Panella on 5/26/17.
//  Copyright © 2017 Blubbr App. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class BeerSearchService {
    
    private let clientID = "2264F50E781D44025CD397BA068537FC0B1CC75B"
    private let clientSecret = "904484AE22B93CF9B651E6BE9B71DF3EC123BD86"
    let searchQuery: String
    
    private let baseSearchURL = "https://api.untappd.com/v4/search/beer"
    
    private var parameters: Parameters {
        return [
            "client_id" : clientID,
            "client_secret" : clientSecret,
            "q" : searchQuery
        ]
    }
    
    init(searchQuery: String) {
        self.searchQuery = searchQuery
    }
    
    func performBeerSearch() {
        
        Alamofire.request(baseSearchURL, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success:
                self.parseSearchResponseData(data: response.data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func parseSearchResponseData(data: Data?) {
        
        guard let responseData = data else {
            return
        }
        
        do {
            let _: BeerSearchResponse = try unbox(data: responseData)
        } catch {
            print(error)
            return
        }
    }
}
