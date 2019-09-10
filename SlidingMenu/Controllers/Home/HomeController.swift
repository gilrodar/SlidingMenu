//
//  HomeController.swift
//  SlidingMenu
//
//  Created by Gil Rodarte on 09/09/19.
//  Copyright © 2019 Gil Rodarte. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    lazy var homeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Home"
        lb.font = UIFont.boldSystemFont(ofSize: 40.0)
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupViews()
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseController)?.openMenu()
    }
    
    func setupLeftBarButtonItem() {
        let imageMenuView = UIImageView(image: #imageLiteral(resourceName: "menu"))
        imageMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMenuView.widthAnchor.constraint(equalToConstant: 32),
            imageMenuView.heightAnchor.constraint(equalToConstant: 32)
            ])
        imageMenuView.contentMode = .scaleAspectFill
        
        let menuTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleOpen))
        menuTapGestureRecognizer.numberOfTapsRequired = 1
        imageMenuView.addGestureRecognizer(menuTapGestureRecognizer)
        
        let leftBarButtonItem = UIBarButtonItem(customView: imageMenuView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    fileprivate func setupNavigationItems() {
        title = "Home"
        setupLeftBarButtonItem()
    }
    
    fileprivate func setupViews() {
        view.addSubview(homeLabel)
        NSLayoutConstraint.activate([
            homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

}
