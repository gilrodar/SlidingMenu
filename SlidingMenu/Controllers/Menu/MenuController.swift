//
//  MenuController.swift
//  SlidingMenu
//
//  Created by Gil Rodarte on 09/09/19.
//  Copyright © 2019 Gil Rodarte. All rights reserved.
//

import UIKit

struct MenuItem {
    let text: String
    let image: UIImage?
}

class MenuController: UIViewController {
    
    lazy var customMenuHeaderView = CustomMenuHeaderView()
    
    lazy var menuTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(MenuItemCell.self, forCellReuseIdentifier: "cellId")
        tv.separatorStyle = .none
        return tv
    }()
    
    var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fillMenuItems()
    }
    
    fileprivate func fillMenuItems() {
        menuItems.append(MenuItem(text: "Home", image: #imageLiteral(resourceName: "home")))
        menuItems.append(MenuItem(text: "Hello", image: #imageLiteral(resourceName: "hello")))
    }
    
    fileprivate func setupViews() {
        view.addSubview(customMenuHeaderView)
        view.addSubview(menuTableView)
        NSLayoutConstraint.activate([
            customMenuHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            customMenuHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customMenuHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            menuTableView.topAnchor.constraint(equalTo: customMenuHeaderView.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "cellId")
        cell.menuIconImageView.image = menuItems[indexPath.row].image?.withRenderingMode(.alwaysTemplate)
        cell.menuTitleLabel.text = menuItems[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentCell = tableView.cellForRow(at: indexPath) as! MenuItemCell
        let baseController = UIApplication.shared.keyWindow?.rootViewController as? BaseController
        baseController?.didSelectMenuItem(action: currentCell.menuTitleLabel.text!)
    }
    
}
