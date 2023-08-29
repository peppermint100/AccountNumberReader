//
//  ViewController.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/08/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = CameraViewController()
        let vc2 = HistoryViewController()
        let vc3 = SettingsViewController()
        
        vc1.title = "스캔"
        vc2.title = "히스토리"
        vc3.title = "설정"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "스캔", image: UIImage(systemName: "camera"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "히스토리", image: UIImage(systemName: "list.bullet"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 3)
        
        setViewControllers([nav2, nav3, nav1], animated: true)
    }
}

