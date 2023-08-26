//
//  mainTabController.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 26/08/23.
//

import UIKit

class MainTabController:UITabBarController{
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureViewController()
    }
    
    // MARK: - Helper
    
    
    
    func configureViewController(){
        
        view.backgroundColor = .white
        
        let feed = FeedController()
        
        
        let search = SearchController()
        
        
        let imageSelector = ImageSelectionController()
        
        let notifications = NotificationsController()
        
        let profile = ProfileController()
        
        viewControllers = [feed,search,imageSelector,notifications,profile]
        
    }
    
    
    
}
