//
//  ViewController.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 02/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    let cellReuseIdentifier = "repositoriesTableViewCell"
    
    var listOfRepositories = [RepositoryDetail]()
    var readmeBase64String = ""

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
        
        let readmeRequest = GitHubRequest(queryString: "/repos/chvin/react-tetris/readme")
        readmeRequest.getReadMeBase64String { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let readmeBase64String):
                print("success! \(readmeBase64String)")
                self.readmeBase64String = readmeBase64String
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        guard let cell:UITableViewCell = repositoriesTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
            fatalError("Could not initialise cell")
        }

        // set the text from the data model
        cell.textLabel?.text = "Text example here!"

        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}

