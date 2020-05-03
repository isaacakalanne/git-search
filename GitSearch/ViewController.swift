//
//  ViewController.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 02/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    let cellReuseIdentifier = "repositoriesTableViewCell"
    
    var listOfRepositories = [RepositoryDetail]()
    var readmeBase64String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        repositoriesTableView.separatorStyle = .none
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Pressed Go!")
        if textField == searchTextField {
            let rawSearchTerm = textField.text ?? ""
            if rawSearchTerm != "" {
                let formattedSearchTerm = formatStringToSearchTerm(rawSearchTerm)
                getRepositories(withSearchTerm: formattedSearchTerm)
                searchTextField.resignFirstResponder()
            }
        }
        return false
    }
    
    func getRepositories(withSearchTerm searchTerm : String) {
        let repositoryRequest = GitHubRequest(queryString: "/search/repositories?q=\(searchTerm)")
        repositoryRequest.getRepositories { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let repositories):
                print("success!")
                self.listOfRepositories = repositories
                DispatchQueue.main.sync {
                    self.repositoriesTableView.reloadData()
                }
            }
        }
    }
    
    func formatStringToSearchTerm(_ inputString : String) -> String {
        let outputString = inputString.replacingOccurrences(of: " ", with: "+")
        return outputString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell:UITableViewCell = repositoriesTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
            fatalError("Could not initialise cell")
        }
        
        cell.selectionStyle = .none
        
        let repositoryDetail = self.listOfRepositories[indexPath.row]
        
        cell.textLabel?.text = repositoryDetail.name ?? "No Name"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}

