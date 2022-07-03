//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/21/22.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
//MARK: - Properties -
    var albumController: AlbumController?
    var tempSongs: [Song] = []
    
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
//MARK: - IBOutlets -
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverUrlsTextField: UITextField!
    
//MARK: - IBActions -
    // When the user taps the Save bar button
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let albumName = albumNameTextField.text, !albumName.isEmpty,
              let artistName = artistNameTextField.text, !artistName.isEmpty,
              let genresString = genresTextField.text, !genresString.isEmpty,
              let coverArtURLsString = coverUrlsTextField.text, !coverArtURLsString.isEmpty,
              tempSongs.count > 0,
              let albumController = albumController else { return }
        
        let genresArray = genresString.split(separator: ",").compactMap({ String($0) })
        let coverArtStrings = coverArtURLsString.split(separator: ",").compactMap({ String($0) })
        
        var coverArtURLs: [URL] = []
        for urlString in coverArtStrings {
            guard let newURL = URL(string: urlString), UIApplication.shared.canOpenURL(newURL) else { continue }
            coverArtURLs.append(newURL)
        }
        guard coverArtURLs.count == coverArtStrings.count else { return }
        
        
        
        if var album = album {
            albumController.update(album: &album, name: albumName, artist: artistName, id: album.id, genres: genresArray, coverArt: coverArtURLs, songs: tempSongs)
        } else {
            albumController.createAlbum(name: albumName, artist: artistName, id: UUID().uuidString, genres: genresArray, coverArt: coverArtURLs, songs: tempSongs)
        }
        
        navigationController?.popViewController(animated: true)
    }

//MARK: - Methods -
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    // Handles updating the UI when an existing album is present
    func updateViews() {
        guard isViewLoaded else { return }
        if let album = album {
            
            let coverArtURLStrings = album.coverArt.compactMap({ $0.absoluteString })
            
            albumNameTextField.text = album.name
            artistNameTextField.text = album.artist
            genresTextField.text = album.genres.joined(separator: ",")
            coverUrlsTextField.text = coverArtURLStrings.joined(separator: ",")
            tempSongs = album.songs
            tableView.reloadData()
            navigationItem.title = album.name
            
        } else {
            navigationItem.title = "New Album"
        }
    }
    
//MARK: - TableView DataSource and Delegate -
    // Number of cells in TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1
    }
    // Configuring each cell in the TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
        cell.delegate = self
        
        let isFinalCell = tempSongs.count == indexPath.row
        cell.song = isFinalCell ? nil : tempSongs[indexPath.row]
        
//        cell.song = tempSongs[indexPath.row]
        return cell
    }
    // Handles height or whatever
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isFinalCell = tempSongs.count == indexPath.row
        let appropriateHeight = isFinalCell ? 140.0 : 100.0
        return appropriateHeight
    }

} //End of class

//MARK: - Extensions -
extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let newSong = albumController!.createSong(id: UUID().uuidString, duration: duration, name: title)
        tempSongs.append(newSong)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: tempSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
