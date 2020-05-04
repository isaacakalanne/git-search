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
    let urlRequest:URLRequest
    let OAUTH_TOKEN = Constants.Keys.OAUTH_TOKEN
    let baseURLString = Constants.GitRequests.BaseURLString
    
    init (queryString: String) {
        let resourceString = baseURLString + queryString
        guard let resourceURL = URL(string: resourceString) else {
            fatalError(Constants.Failures.couldNotCreateURL)
        }
        
        self.resourceURL = resourceURL
        
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.setValue("token \(OAUTH_TOKEN)", forHTTPHeaderField: "Authorization")
        self.urlRequest = urlRequest
        
    }
    
    func getRepositories(completion: @escaping(Result<[RepositoryDetail], GitHubError>) -> Void) {
        
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
    
    func getReadMeBase64String(completion: @escaping(Result<String, GitHubError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil {
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let readMeResponse = try decoder.decode(ReadMe.self, from: jsonData)
                    let readMeBase64String = readMeResponse.content ?? Constants.EmptyString
                    completion(.success(readMeBase64String))
                } catch {
                    completion(.failure(.canNotProcessData))
                }
                
            }
            
        }
        dataTask.resume()
    }
}
