//
//  QUser.swift
//  QChat
//
//  Created by Vigneshraj Sekar Babu on 7/26/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation

class QUser {
    
    let userID : String
    let registerDate : Date
    let lastUpdatedDate : Date
    
    var email: String
    var firstName: String
    var lastName: String
    var country: String
    var city: String
    var mobile: String
    var isOnline: Bool
    var hasProfile: Bool
    var avatar: String

    init(_userID: String, _registerDate: Date, _lastUpdatedDate: Date, _email: String, _firstName: String, _lastName: String, _country: String, _city: String, _mobile: String, _isOnline: Bool, _hasProfile: Bool, _avatar: String) {
        
        userID = _userID
        registerDate = _registerDate
        lastUpdatedDate = _lastUpdatedDate
        email = _email
        firstName = _firstName
        lastName = _lastName
        country = _country
        city = _city
        mobile = _mobile
        isOnline = _isOnline
        hasProfile = _hasProfile
        avatar = _avatar
    }
    
    
    
}
