//
//  CustomMenuHeaderView.swift
//  SlidingMenu
//
//  Created by Gil Rodarte on 09/09/19.
//  Copyright © 2019 Gil Rodarte. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    lazy var userNameLabel: UILabel = {
        var lb = UILabel()
        lb.text = "Gil Rodarte"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 22.0)
        return lb
    }()
    
    lazy var manuLabel: UILabel = {
        var lb = UILabel()
        lb.text = "Menu Controller"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 18.0)
        return lb
    }()
    
    lazy var customMenuHeaderStackView: UIStackView = {
        let arrangedSubviews = [
            userNameLabel,
            manuLabel
        ]
        let sv = UIStackView(arrangedSubviews: arrangedSubviews)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .blue
        setupViews()
    }
    
    fileprivate func setupViews() {
        addSubview(customMenuHeaderStackView)
        NSLayoutConstraint.activate([
            customMenuHeaderStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customMenuHeaderStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customMenuHeaderStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customMenuHeaderStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        customMenuHeaderStackView.isLayoutMarginsRelativeArrangement = true
        customMenuHeaderStackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
