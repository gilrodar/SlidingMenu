//
//  BaseController.swift
//  SlidingMenu
//
//  Created by Gil Rodarte on 09/09/19.
//  Copyright © 2019 Gil Rodarte. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    lazy var homeContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    lazy var menuContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        return v
    }()
    
    lazy var darkCoverView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0, alpha: 0.6)
        v.alpha = 0
        return v
    }()
    
    var homeViewLeadingConstraint: NSLayoutConstraint!
    var homeViewTrailingConstraint: NSLayoutConstraint!
    fileprivate var menuWidth: CGFloat!
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false
    var homeController: UINavigationController = UINavigationController(rootViewController: HomeController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapClose))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        homeViewLeadingConstraint.constant = x
        homeViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    @objc func handleTapClose() {
        closeMenu()
    }
    
    func openMenu() {
        isMenuOpened = true
        homeViewLeadingConstraint.constant = menuWidth
        homeViewTrailingConstraint.constant = menuWidth
        performAnimations()
    }
    
    func closeMenu() {
        homeViewLeadingConstraint.constant = 0
        homeViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }
    
    func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        if isMenuOpened {
            if velocity.x < -velocityThreshold {
                closeMenu()
                return
            }
            abs(translation.x) < menuWidth / 2 ? openMenu() : closeMenu()
        } else {
            if velocity.x > velocityThreshold {
                openMenu()
                return
            }
            translation.x < menuWidth / 2 ? closeMenu() : openMenu()
        }
    }
    
    func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    func didSelectMenuItem(action: String) {
        switch action {
        case "Home":
            showNewController(controller: HomeController())
        case "Hello":
            showNewController(controller: HelloController())
        default:
            print("Press a menu option")
        }
    }
    
    func performHomeViewCleanUp() {
        homeController.view.removeFromSuperview()
        homeController.removeFromParent()
    }
    
    func showNewController(controller: UIViewController) {
        closeMenu()
        performHomeViewCleanUp()
        homeController = UINavigationController(rootViewController: controller)
        homeContainerView.addSubview(homeController.view)
        addChild(homeController)
        homeContainerView.bringSubviewToFront(darkCoverView)
    }
    
    fileprivate func setupViews() {
        menuWidth = view.frame.size.width - 70
        view.addSubview(homeContainerView)
        view.addSubview(menuContainerView)
        NSLayoutConstraint.activate([
            homeContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            homeContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuContainerView.trailingAnchor.constraint(equalTo: homeContainerView.leadingAnchor),
            menuContainerView.widthAnchor.constraint(equalToConstant: menuWidth),
            menuContainerView.bottomAnchor.constraint(equalTo: homeContainerView.bottomAnchor)
            ])
        homeViewLeadingConstraint = homeContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        homeViewLeadingConstraint.isActive = true
        homeViewTrailingConstraint = homeContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        homeViewTrailingConstraint.isActive = true
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        let menuController = MenuController()
        let homeView = homeController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        homeContainerView.addSubview(homeView)
        homeContainerView.addSubview(darkCoverView)
        menuContainerView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: homeContainerView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: homeContainerView.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: homeContainerView.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: homeContainerView.bottomAnchor),
            
            menuView.topAnchor.constraint(equalTo: menuContainerView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: menuContainerView.bottomAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: homeContainerView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: homeContainerView.leadingAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: homeContainerView.trailingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: homeContainerView.bottomAnchor)
            ])
        
        addChild(homeController)
        addChild(menuController)
    }

}
