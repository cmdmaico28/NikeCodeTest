//
//  DetailViewController.swift
//  NikeCodeTest
//
//  Created by Miguel Perez on 10/3/19.
//  Copyright © 2019 Miguel Perez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var albumVM: AlbumViewModel?
    
    
    lazy var albumArtImgView: UIImageView = {
        
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var copyrightLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: label.font.familyName, size: 17)
        label.numberOfLines = 0
        label.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
        
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: label.font.familyName, size: 24)
        label.textColor = UIColor(red: 200, green: 0, blue: 0, alpha: 0.8)
        
        return label
    }()
    
    lazy var genreLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: label.font.familyName, size: 19)
        
        return label
    }()
    

    
    lazy var actionButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Go To Album Page", for: UIControl.State.normal)
        button.setTitleColor( .white, for: UIControl.State.normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(self.actionButtonClicked), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Details"
        
        self.view.addSubview(self.albumArtImgView)
        self.view.addSubview(self.copyrightLabel)
        self.view.addSubview(self.albumNameLabel)
        self.view.addSubview(self.artistNameLabel)
        self.view.addSubview(self.genreLabel)
        self.view.addSubview(self.releaseDateLabel)
        self.view.addSubview(self.actionButton)
        
        setupConstraints()
        setupViews()
    }
    
    func setupConstraints() {
        
        self.albumArtImgView.translatesAutoresizingMaskIntoConstraints = false
        self.albumArtImgView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.albumArtImgView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.albumArtImgView.centerXAnchor.constraint(equalToSystemSpacingAfter: self.view.centerXAnchor, multiplier: 1).isActive = true
        self.albumArtImgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        self.copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        self.copyrightLabel.topAnchor.constraint(equalTo: self.albumArtImgView.bottomAnchor, constant: 2).isActive = true
        self.copyrightLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        self.copyrightLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        
        self.albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.albumNameLabel.topAnchor.constraint(equalTo: self.copyrightLabel.bottomAnchor, constant: 30).isActive = true
        self.albumNameLabel.leftAnchor.constraint(equalTo: self.copyrightLabel.leftAnchor).isActive = true
        self.albumNameLabel.rightAnchor.constraint(equalTo: self.copyrightLabel.rightAnchor).isActive = true
        
        self.artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.artistNameLabel.topAnchor.constraint(equalTo: self.albumNameLabel.bottomAnchor, constant: 6).isActive = true
        self.artistNameLabel.leftAnchor.constraint(equalTo: self.copyrightLabel.leftAnchor).isActive = true
        self.artistNameLabel.rightAnchor.constraint(equalTo: self.copyrightLabel.rightAnchor).isActive = true
        
        self.genreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.genreLabel.topAnchor.constraint(equalTo: self.artistNameLabel.bottomAnchor, constant: 10).isActive = true
        self.genreLabel.leftAnchor.constraint(equalTo: self.copyrightLabel.leftAnchor).isActive = true
        self.genreLabel.rightAnchor.constraint(equalTo: self.copyrightLabel.rightAnchor).isActive = true
        
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.releaseDateLabel.topAnchor.constraint(equalTo: self.genreLabel.bottomAnchor, constant: 10).isActive = true
        self.releaseDateLabel.leftAnchor.constraint(equalTo: self.copyrightLabel.leftAnchor).isActive = true
        self.releaseDateLabel.rightAnchor.constraint(equalTo: self.copyrightLabel.rightAnchor).isActive = true
    
        
        self.actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.actionButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupViews() {
        
        guard let albumVM = self.albumVM, let album = self.albumVM?.album else { return }
        
        self.artistNameLabel.text = album.artistName
        self.albumNameLabel.text = album.name
        self.genreLabel.text = albumVM.albumGenre
        self.releaseDateLabel.text = album.releaseDate
        self.copyrightLabel.text = album.copyright
        self.albumArtImgView.image = albumVM.artworkImg
    }
    
    @objc func actionButtonClicked() {
        
        guard let urlString = self.albumVM?.album.url, let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
        
            UIApplication.shared.open(url)
        }
    }

}
