//
//  TabBarViewController.swift
//  N2FLIX
//
//  Created by 송정훈 on 4/24/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupTabBar()
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage() // add this if you want remove tabBar separator
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .black // here is your tabBar color
        tabBar.layer.backgroundColor = UIColor.clear.cgColor


        let blurEffect = UIBlurEffect(style: .dark) // here you can change blur style
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = .flexibleWidth
        tabBar.insertSubview(blurView, at: 0)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.ChangeHeightOfTabbar()
        
    }
    func ChangeHeightOfTabbar() {
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame = tabBar.frame
            tabFrame.size.height = 90
            tabFrame.origin.y = view.frame.size.height - 90
            tabBar.frame = tabFrame
        }
    }
    private func setupTabBar() {
        tabBar.backgroundColor =  UIColor(red: 0.129, green: 0.129, blue: 0.133, alpha: 0.6)
        tabBar.frame = CGRect(x: 0, y: 0, width: 375, height: 90)
        tabBar.layer.masksToBounds =  true
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.4
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
