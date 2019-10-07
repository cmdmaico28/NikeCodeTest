//
//  ViewController.swift
//  NikeCodeTest
//
//  Created by Miguel Perez on 10/2/19.
//  Copyright © 2019 Miguel Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    var AlbumsArray = [AlbumViewModel]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Top 100 Albums"
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getTopAlbums()
    }
    
    func getTopAlbums() {
        
        WebServiceManager.sharedInstance.getTopAlbums(limit: 100, completion: { success, error, albumViewModel in
            
            if success {
                
                guard let albumViewModel = albumViewModel else { return }
                
                self.AlbumsArray.append(albumViewModel)
                //Download Album's Image
                albumViewModel.downloadAlbumImage { success in
                    if success {
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }

 
    func setTableView() {
        
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.darkGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlbumsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as?
            CustomTableViewCell else {fatalError("Unable to create cell")}
       
        let item = AlbumsArray[indexPath.row]
      
        if item.artworkImg == nil {
            cell.activity.startAnimating()
        } else {
            cell.activity.stopAnimating()
            cell.albumImageView.image = item.artworkImg
        }
        
        
        cell.albumNameLabel.text = item.album.name
        cell.artistNameLabel.text = item.album.artistName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let albumVM = self.AlbumsArray[indexPath.row]
        
        let detailVC = DetailViewController()
        detailVC.albumVM = albumVM
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

