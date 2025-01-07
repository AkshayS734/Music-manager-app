//
//  ViewController.swift
//  MusicManagerApp
//
//  Created by Batch - 1 on 06/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    let songs : [Song] = [Song(name: "Be Humble", artist: "Kendrick Lamar", duration: 343),Song(name: "I was made for loving you", artist: "Dominic Lewis", duration: 236),Song(name: "Bye Bye Bye", artist: "NSYNC", duration: 447),Song(name: "Die With A Smile", artist: "Bruno Mars & Lady Gaga", duration: 520),Song(name: "Starboy", artist: "The Weeknd", duration: 300)]
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songDuration: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    
    
    var currentSongIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySongDetails(song: songs[0])
        
    }
    
    func displaySongDetails(song: Song) {
        songName.text = song.name
        artistName.text = song.artist
        songDuration.text = formatDuration(song.duration)
        albumImage.image = UIImage(named: "\(song.name).jpeg")
    }
    
    func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        moveToNextSong()
    }
    @IBAction func backwardButtonTapped(_ sender: UIButton) {
        moveToPreviousSong()
    }
    func moveToNextSong() {
        if currentSongIndex < songs.count - 1 {
            currentSongIndex += 1
        } else {
            currentSongIndex = 0
        }
        displaySongDetails(song: songs[currentSongIndex])
    }

    func moveToPreviousSong() {
        if currentSongIndex > 0 {
            currentSongIndex -= 1
        } else {
            currentSongIndex = songs.count - 1
        }
        displaySongDetails(song: songs[currentSongIndex])
    }
    @IBAction func playButtonTapped(_ sender: UIButton) {
        let song = songs[currentSongIndex]
        showAlert(title: "Now Playing", message: "Now Playing: \(song.name)")
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        showAlert(title: "Playback Paused", message: "Playback Paused")
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

