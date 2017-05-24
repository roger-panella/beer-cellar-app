//
//  UntappdAuthenticator.swift
//  Blubbr
//
//  Created by Ben Munge on 5/20/17.
//  Copyright © 2017 Blubbr App. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

public class UntappdAuthenticator {
    
    public static let sharedInstance = UntappdAuthenticator()
    
    private let clientID = "2264F50E781D44025CD397BA068537FC0B1CC75B"
    private let clientSecret = "904484AE22B93CF9B651E6BE9B71DF3EC123BD86"
    private let authenticateURL = "https://untappd.com/oauth/authenticate"
    private let authorizeURL = "https://untappd.com/oauth/authorize"
    private let responseType = "code"
    private let redirectURL = "blubbr://oauth-callback"
    
    private var authenticateParameters: Parameters {
        return [
            "client_id" : clientID,
            "response_type" : responseType,
            "redirect_url" : redirectURL
        ]
    }
    
    private var authorizationParameters: Parameters {
        return [
            "client_id" : clientID,
            "client_secret" : clientSecret,
            "response_type" : responseType,
            "redirect_url" : redirectURL
        ]
    }
    
    private init() {}

    public func requestAuthentication() {
        guard let components = NSURLComponents(string: authenticateURL) else {
            fatalError("Invalid authenticate url specified by application")
        }
        
        components.queryItems = authenticateParameters.map { return URLQueryItem(name: $0.key, value: ($0.value as? String) ?? "") }
        
        guard let requestURL = components.url else {
            fatalError("Invalid authenticate url specified by application")
        }
        
        UIApplication.shared.open(requestURL, options: authenticateParameters, completionHandler: nil)
    }
    
    public func authorizeWithToken(token: String) {
        var parameters = authorizationParameters
        parameters["code"] = token
        
        Alamofire.request(authorizeURL, parameters: parameters).responseJSON { response in
            
            guard response.result.isSuccess else {
                fatalError("Authorization request failed")
            }
            
            guard let data = response.data else {
                fatalError("No response data")
            }
            
            do {
                let unboxer = try Unboxer(data: data)
                let authResponse = try UntappdAuthorizationResponse(unboxer: unboxer)
                print(authResponse.accessToken)
            } catch {
                print("Oops")
            }
        }
    }
}

private struct UntappdAuthorizationResponse: Unboxable {
    
    let accessToken: String
    
    init(unboxer: Unboxer) throws {
        accessToken = try unboxer.unbox(keyPath: "response.access_token")
    }
}
