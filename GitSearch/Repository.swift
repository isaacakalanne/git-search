//
//  Repository.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 02/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import Foundation

struct Repositories:Decodable {
    var items:[RepositoryDetail]
}

struct RepositoryDetail:Decodable {
    var name:String?
    var full_name:String?
    var owner:OwnerDetail?
    var description:String?
    
    var forks_count:Int?
    var open_issues_count:Int?
}

struct OwnerDetail:Decodable {
    var login:String?
    var id:Int?
    var avatar_url:String?
}
