//
//  MyNavigationController.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 4.11.2023.
//


import UIKit

class MyNavigationController : UINavigationController{
    
    override func viewDidLoad() {
        
        viewControllers = [SplashController()] // viewControllers : Şuanda gezinen görünüm denetleyicileri
    }
    
    func gonewHomeController() {
        
        let homeController = HomeController()
        // Tam 2 kodun arasına kodlar eklenebilir..
        pushViewController(homeController, animated: true)
        viewControllers.removeAll(){
            $0 is SplashController
        }
        
    
    }
    
    
}
