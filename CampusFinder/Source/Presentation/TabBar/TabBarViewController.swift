//
//  TabBarViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/25/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor(hexCode: "B8B9C6")
        
//        let home = HomeViewController()
//        let nav1 = UINavigationController(rootViewController: home)
//        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeTab"), tag: 0)
//        
//        let favorite = ChattingViewController()
//        let nav2 = UINavigationController(rootViewController: favorite)
//        nav2.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "chattingTab"), tag: 1)
//        
//        let profile = ProfileViewController()
//        let nav3 = UINavigationController(rootViewController: profile)
//        nav3.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "profileTab"), tag: 2)
//        
//        setViewControllers([nav1,nav2,nav3], animated: true)
        
        let home = HomeViewController()
        home.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeTab"), tag: 0)
        
        let favorite = ChattingViewController()
        favorite.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "chattingTab"), tag: 1)
        
        let profile = ProfileViewController()
        profile.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "profileTab"), tag: 2)
        
        setViewControllers([home,favorite,profile], animated: true)
    }
}
