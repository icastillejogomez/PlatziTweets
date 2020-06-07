//
//  RegisterRequest.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 07/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import Foundation

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let names: String
}
