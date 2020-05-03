//
//  DetailViewController.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 03/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var openIssuesTitleLabel: UILabel!
    
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var readMeTextView: UITextView!
    
    var repositoryDetail:RepositoryDetail?
    var readMeString = ""
    let readMeNotAvailable = "No readme available."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coverImageView.backgroundColor = openIssuesTitleLabel.backgroundColor
        
        setProfilePictureImage(fromURLString: repositoryDetail?.owner?.avatar_url ?? "")
        roundCorners(ofView: profilePictureImageView)
        setBorder(forView: profilePictureImageView)
        fullNameLabel.text = repositoryDetail?.full_name ?? "No name available."
        
        setCountLabelsText()
        descriptionTextView.text = repositoryDetail?.description ?? "No description available."
        setReadMeText()
        
    }
    
    func roundCorners(ofView view : UIView) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.frame.size.height / 2
    }
    
    func setCountLabelsText() {
        let openIssuesCount = repositoryDetail?.open_issues_count ?? -1
        setText(forCountLabel: openIssuesLabel, withCount: openIssuesCount)
        
        let forksCount = repositoryDetail?.forks_count ?? -1
        setText(forCountLabel: forkCountLabel, withCount: forksCount)
    }
    
    func setText(forCountLabel label : UILabel, withCount count : Int) {
        if count != -1 {
            label.text = String(count)
        } else {
            label.text = "Not available"
        }
    }
    
    func setReadMeText() {
        let fullName = repositoryDetail?.full_name ?? ""
        let readmeRequest = GitHubRequest(queryString: "/repos/\(fullName)/readme")
        readmeRequest.getReadMeBase64String { result in
            
            switch result {
            case .failure(let error):
                
                self.displayReadMeAsNotAvailable()
                print(error)
                
            case .success(let readmeBase64String):
                
                self.readMeString = self.decodeBase64String(readmeBase64String)
                DispatchQueue.main.async {
                    self.readMeTextView.text = self.readMeString
                }
                
            }
        }
    }
    
    func displayReadMeAsNotAvailable() {
        DispatchQueue.main.async {
            self.readMeTextView.text = self.readMeNotAvailable
        }
    }
    
    func decodeBase64String(_ base64String : String) -> String {
        guard let stringData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            self.displayReadMeAsNotAvailable()
            return readMeNotAvailable
        }
        let readMeString = String(data: stringData, encoding: .utf8) ?? readMeNotAvailable
        return readMeString
    }
    
    func setBorder(forView view : UIView) {
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5
    }
    
    func setProfilePictureImage(fromURLString urlString : String) {
        DispatchQueue.global().async {
            let url = URL(string: urlString)
            guard let data = try? Data(contentsOf: url!) else {
                fatalError("Could not download profile picture image")
            }
            DispatchQueue.main.async {
                self.profilePictureImageView.image = UIImage(data: data)
            }
        }
    }
    
}
