//
//  OEXSession+Authorization.swift
//  edX
//
//  Created by Akiva Leffert on 5/19/15.
//  Copyright (c) 2015 edX. All rights reserved.
//

import Foundation

extension OEXSession : AuthorizationHeaderProvider {
    public var authorizationHeaders : [String:String] {
        if let accessToken = self.token?.accessToken, let tokenType = self.token?.tokenType {
            return ["Authorization" : "\(tokenType) \(accessToken)"]
        } else if let cookies = HTTPCookieStorage.shared.cookies {
            var csrfTokenValue = ""
            var values = ""
            var referer = "https://"
            for cookie in cookies{
                values += "; " + String(format: "%@=%@", cookie.name, cookie.value)
                if cookie.name == "csrftoken"{
                    csrfTokenValue = cookie.value
                    referer += cookie.domain
                }
            }
            return ["Cookie" : values, "X-CSRFToken": csrfTokenValue, "Referer":referer]
        }
        else {
            return [:]
        }
    }
}
