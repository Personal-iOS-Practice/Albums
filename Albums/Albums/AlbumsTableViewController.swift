//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/21/22.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
//MARK: - Properties -
    var albumController = AlbumController()

//MARK: - Methods -
    // Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        albumController.getAlbums(completion: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
// MARK: - TableView DataSource and Delegate -
    // Number of cells in TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }
    // Configuring each cell in the TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        let currentAlbum = albumController.albums[indexPath.row]
        cell.textLabel?.text = currentAlbum.name
        cell.detailTextLabel?.text = currentAlbum.artist
        
        return cell
    }
    
// MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewAlbumSegue" {
            let destinationVC = segue.destination as! AlbumDetailTableViewController
            destinationVC.albumController = albumController
            
        } else if segue.identifier == "AlbumDetailSegue" {
            let destinationVC = segue.destination as! AlbumDetailTableViewController
            let selectedCellIndex = tableView.indexPathForSelectedRow!
            let selectedAlbum = albumController.albums[selectedCellIndex.row]
            destinationVC.albumController = albumController
            destinationVC.album = selectedAlbum
            
        }
    }

} //End of class
