//
//  ViewController.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 02/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    let cellReuseID = Constants.Identifiers.repositoriesTableViewCellID
    let detailViewSegueID = Constants.Identifiers.detailViewSegueID
    let noNameAvailable = Constants.Failures.noNameAvailable
    let couldNotInitialiseCell = Constants.Failures.couldNotInitiaiseCell
    
    var listOfRepositories = [RepositoryDetail]()
    
    let validChars = Constants.Sets.validSearchTermChars

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            let rawSearchTerm = textField.text ?? Constants.EmptyString
            if rawSearchTerm != Constants.EmptyString {
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
                self.listOfRepositories = repositories
                DispatchQueue.main.sync {
                    self.repositoriesTableView.reloadData()
                }
            }
        }
    }
    
    func formatStringToSearchTerm(_ inputString : String) -> String {
        let filteredString = inputString.filter { validChars.contains($0) }
        let outputString = filteredString.replacingOccurrences(of: " ", with: "+")
        
        return outputString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell:UITableViewCell = repositoriesTableView.dequeueReusableCell(withIdentifier: cellReuseID) else {
            fatalError(couldNotInitialiseCell)
        }
        
        let repositoryDetail = self.listOfRepositories[indexPath.row]
        
        cell.textLabel?.text = repositoryDetail.name ?? noNameAvailable

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDetail = self.listOfRepositories[indexPath.row]
        let fullName = repoDetail.full_name
        UserDefaults.standard.set(fullName, forKey: Constants.Keys.fullName)
        self.performSegue(withIdentifier: detailViewSegueID, sender: repoDetail)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as? DetailViewController
        destinationVC?.repositoryDetail = sender as? RepositoryDetail
        
    }

}

