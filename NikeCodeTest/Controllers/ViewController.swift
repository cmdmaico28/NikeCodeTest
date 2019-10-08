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
            
            if success, let albumViewModel = albumViewModel {
                
                self.AlbumsArray.append(albumViewModel)
                self.tableView.reloadData()
                
                //Download Album's Image
                albumViewModel.downloadAlbumImage(index: self.AlbumsArray.count-1) { index, success in
                    if success {
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            } else if let error = error {
                print(error)
            }
        })
    }

 
    func setTableView() {
        
        self.tableView.frame = self.view.frame
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorColor = UIColor.darkGray
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
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

