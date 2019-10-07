//
//  CustomTableViewCell.swift
//  NikeCodeTest
//
//  Created by Miguel Perez on 10/3/19.
//  Copyright © 2019 Miguel Perez. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    lazy var backView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var albumImageView: UIImageView = {
        
        let userImage = UIImageView()
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    
    lazy var albumNameLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        
        let activity = UIActivityIndicatorView(style: .gray)
        activity.hidesWhenStopped = true
        return activity
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(backView)
        self.backView.addSubview(self.albumImageView)
        self.backView.addSubview(self.albumNameLabel)
        self.backView.addSubview(self.artistNameLabel)
        self.backView.addSubview(self.activity)
        
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.gray
        backView.layer.cornerRadius = 5
        
        self.setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {

        self.backView.translatesAutoresizingMaskIntoConstraints = false
        self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 3).isActive = true
        self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -3).isActive = true
        self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3).isActive = true
        self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3).isActive = true
        
        self.albumImageView.translatesAutoresizingMaskIntoConstraints = false
        self.albumImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.albumImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.albumImageView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 5).isActive = true
        self.albumImageView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 5).isActive = true
        self.albumImageView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -5).isActive = true
        
        self.activity.leadingAnchor.constraint(equalTo: self.albumImageView.leadingAnchor, constant: 35).isActive = true
        self.activity.topAnchor.constraint(equalTo: self.albumImageView.topAnchor, constant: 35).isActive = true
        
        
        self.albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.albumNameLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 5).isActive = true
        self.albumNameLabel.leadingAnchor.constraint(equalTo: self.albumImageView.trailingAnchor, constant: 15).isActive = true
        self.albumNameLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -15).isActive = true
        
        self.artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.artistNameLabel.topAnchor.constraint(equalTo: self.albumNameLabel.bottomAnchor, constant: 5).isActive = true
        self.artistNameLabel.leftAnchor.constraint(equalTo: self.albumNameLabel.leftAnchor).isActive = true
        self.artistNameLabel.rightAnchor.constraint(equalTo: self.albumNameLabel.rightAnchor).isActive = true
        self.artistNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.backView.bottomAnchor, constant: -5).isActive = true
    }
}
