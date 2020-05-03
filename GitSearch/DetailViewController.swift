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
    @IBOutlet weak var forkCountTitleLabel: UILabel!
    
    var repositoryDetail:RepositoryDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.text = repositoryDetail?.full_name ?? "No name available"
        
        setProfilePictureImage(fromURLString: repositoryDetail?.owner?.avatar_url ?? "")
        setBorder(forView: profilePictureImageView)
        roundCorners(ofView: profilePictureImageView)
        roundCorners(ofView: openIssuesTitleLabel)
        roundCorners(ofView: forkCountTitleLabel)
    }
    
    func setBorder(forView view : UIView) {
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5
    }
    
    func roundCorners(ofView view : UIView) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.frame.size.height / 2
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
