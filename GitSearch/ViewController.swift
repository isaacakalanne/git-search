//
//  ViewController.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 02/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfRepositories = [RepositoryDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let repositoryRequest = GitHubRequest(queryString: "/search/repositories?q=Tetris")
        repositoryRequest.getRepositories { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let repositories):
                print("success!")
                self.listOfRepositories = repositories
            }
        }
        
    }

}

