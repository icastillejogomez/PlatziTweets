//
//  LoginResponse.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 07/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import Foundation

struct LoginResponse: Codable { 
    let user: User
    let token: String
}
