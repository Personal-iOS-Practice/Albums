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
    var album: Album?
    
//MARK: - IBOutlets -
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverUrlsTextField: UITextField!
    
//MARK: - IBActions -
    // When the user taps the Save bar button
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }

//MARK: - Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - TableView DataSource and Delegate -
    // Number of cells in TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    // Configuring each cell in the TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        // configure cell here...
        
        return cell
    }
    
//MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

} //End of class
