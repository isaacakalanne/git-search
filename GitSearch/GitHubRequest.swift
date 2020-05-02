//
//  RepositoryRequest.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 02/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import Foundation

enum GitHubError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct GitHubRequest {
    let resourceURL:URL
    let OAUTH_TOKEN = "4e925ba7687aff26103419bfb6362699f5b52abf"
    
    init (searchTerm: String) {
        let resourceString = "https://api.github.com/search/repositories?q=\(searchTerm)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getRepositories(completion: @escaping(Result<[RepositoryDetail], GitHubError>) -> Void) {
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.setValue("token \(OAUTH_TOKEN)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil {
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let repositoriesResponse = try decoder.decode(Repositories.self, from: jsonData)
                    let repositoryDetails = repositoriesResponse.items
                    completion(.success(repositoryDetails))
                } catch {
                    completion(.failure(.canNotProcessData))
                }
            }
            
        }
        dataTask.resume()
    }
}
