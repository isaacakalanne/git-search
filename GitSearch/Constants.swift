//
//  Constants.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 04/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import Foundation

struct Constants {
    
    static let EmptyString = ""
    
    struct Identifiers {
        static let repositoriesTableViewCellID = "repositoriesTableViewCell"
        static let detailViewSegueID = "openDetailViewSegue"
    }
    
    struct Sets {
        static let validSearchTermChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
    }
    
    struct Keys {
        static let fullName = "fullName"
        static let OAUTH_TOKEN = "4e925ba7687aff26103419bfb6362699f5b52abf"
    }
    
    struct Failures {
        static let readMeIsEmpty = "Readme is empty."
        static let readMeNotAvailable = "No readme available."
        static let noFullNameAvailable = "No full name available."
        static let noNameAvailable = "No name available."
        static let noDescriptionAvailable = "No description available."
        static let notAvailable = "Not available."
        static let couldNotDownloadProfilePicture = "Could not download profile picture image."
        static let couldNotInitiaiseCell = "Could not initialise cell."
        static let couldNotCreateURL = "Could not create URL."
    }
}
