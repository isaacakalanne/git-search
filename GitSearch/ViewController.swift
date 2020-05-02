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
    var readmeBase64String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let githubRequest = GitHubRequest(queryString: "/repos/chvin/react-tetris/readme")
        githubRequest.getReadMeBase64String { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let readmeBase64String):
                print("success! \(readmeBase64String)")
                self.readmeBase64String = readmeBase64String
            }
        }
        
    }

}

