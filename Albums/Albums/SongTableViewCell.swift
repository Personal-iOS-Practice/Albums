//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/21/22.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
//MARK: - Properties
    var song: Song?
    var delegate: SongTableViewCellDelegate?

//MARK: - IBOutlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
//MARK: - Methods -
    // Assign the Song's values to the views in the cell
    func updateViews() {
        guard let song = song else { return }
        songTitleTextField.text = song.name
        songDurationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    // Clear up the cell to be reused for a new song
    override func prepareForReuse() {
        super.prepareForReuse()
        songTitleTextField.text = ""
        songDurationTextField.text = ""
        addSongButton.isHidden = false
    }
    
//MARK: - IBActions
    // When the user taps the Add Song button
    @IBAction func addSongButtonTapped(_ sender: UIButton) {
        guard let title = songTitleTextField.text,
              let duration = songDurationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
} //End of class

//MARK: - Delegate Protocols -
protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}
