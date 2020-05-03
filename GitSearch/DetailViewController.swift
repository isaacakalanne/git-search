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
    
    var repositoryDetail:RepositoryDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.text = repositoryDetail?.full_name ?? "No name"
        
    }
    
}
