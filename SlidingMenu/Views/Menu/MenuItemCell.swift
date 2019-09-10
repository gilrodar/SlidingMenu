//
//  MenuItemCell.swift
//  SlidingMenu
//
//  Created by Gil Rodarte on 09/09/19.
//  Copyright © 2019 Gil Rodarte. All rights reserved.
//

import UIKit

class MenuIconImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        return .init(width: 34, height: 34)
    }
}

class MenuItemCell: UITableViewCell {

    lazy var menuIconImageView: MenuIconImageView = {
        let iv = MenuIconImageView()
        iv.contentMode = .scaleToFill
        iv.tintColor = .black
        return iv
    }()
    
    lazy var menuTitleLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    lazy var menuItemStackView: UIStackView = {
        let arrangedSubviews = [
            menuIconImageView,
            SpacerView(space: 10),
            menuTitleLabel,
            UIView()
        ]
        let sv = UIStackView(arrangedSubviews: arrangedSubviews)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    fileprivate func setupViews() {
        addSubview(menuItemStackView)
        NSLayoutConstraint.activate([
            menuItemStackView.topAnchor.constraint(equalTo: topAnchor),
            menuItemStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuItemStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuItemStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        menuItemStackView.isLayoutMarginsRelativeArrangement = true
        menuItemStackView.layoutMargins = .init(top: 8, left: 20, bottom: 8, right: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
