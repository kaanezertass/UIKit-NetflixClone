//
//  ViewController.swift
//  AnkaraMeyhaneler
//
//  Created by Kaan Ezerrtaş on 18.10.2023.
//

import UIKit

class MainTabViewController: UITabBarController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        
        //Ekran Geçişleri
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpdateViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: RoadViewController())
            
        //TabBar item resimleri (Sf Symbols)
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "star.fill")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "mappin.circle.fill")
        
        //TabBar itemlerin başlıkları
        vc1.title = "Ev"
        vc2.title = "Favoriler"
        vc3.title = "Ara"
        vc4.title = "Konum"
        
        tabBar.tintColor = .label //TabBar item renklerini belirleme
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true) //Görüntülenecek viewlar
       
        
        
        
    }


    

}

