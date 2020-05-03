//
//  DetailViewController.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 03/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    var repositoryDetail:RepositoryDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let login = repositoryDetail?.owner?.login
        print(login ?? "No login")
    }
    
}
