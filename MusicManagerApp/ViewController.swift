import UIKit

class ViewController: UIViewController {
    
    let songs : [Song] = [
        Song(name: "Be Humble", artist: "Kendrick Lamar", duration: 343),
        Song(name: "I was made for loving you", artist: "Dominic Lewis", duration: 236),
        Song(name: "Bye Bye Bye", artist: "NSYNC", duration: 447),
        Song(name: "Die With A Smile", artist: "Bruno Mars & Lady Gaga", duration: 520),
        Song(name: "Starboy", artist: "The Weeknd", duration: 300)
    ]
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songDuration: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songProgressView: UIProgressView!
    
    
    var currentSongIndex: Int = 0
    var timer: Timer?
    var currentProgress: TimeInterval = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySongDetails(song: songs[0])
        setupUI()
    }

    func displaySongDetails(song: Song) {
        songName.text = song.name
        artistName.text = song.artist
        songDuration.text = formatDuration(song.duration)
        albumImage.image = UIImage(named: "\(song.name).jpeg")
        songProgressView.progress = 0.0
        currentProgress = 0.0
    }
        
    func formatDuration(_ duration: TimeInterval) -> String {
        print("Duration received:", duration)
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)    }
        
    func setupUI() {
        pauseButton.isHidden = true
        pauseButton.isEnabled = false
    }
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        moveToNextSong()
    }
    @IBAction func backwardButtonTapped(_ sender: UIButton) {
        moveToPreviousSong()
    }
    func moveToNextSong() {
        stopTimer()
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
        resetPlayback()
        displaySongDetails(song: songs[currentSongIndex])
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        let song = songs[currentSongIndex]
        showAlert(title: "Now Playing", message: "Now Playing: \(song.name)")
        playButton.isEnabled = false
        playButton.isHidden = true
        pauseButton.isEnabled = true
        pauseButton.isHidden = false
        startTimer(for: song.duration)
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        showAlert(title: "Playback Paused", message: "Playback Paused")
        playButton.isEnabled = true
        playButton.isHidden = false
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
        stopTimer()
    }
    
    func startTimer(for duration: TimeInterval) {
        timer?.invalidate() // Stop any previous timers
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateProgress(duration: duration)
        }
    }
        
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
        
    func updateProgress(duration: TimeInterval) {
        guard currentProgress < duration else {
            stopTimer()
            resetPlayback()
            return
        }
        currentProgress += 1
        songProgressView.progress = Float(currentProgress / duration)
        timerLabel.text = "\(formatDuration(currentProgress))"
    }
        
    func resetPlayback() {
        stopTimer()
        playButton.isEnabled = true
        playButton.isHidden = false
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
        songProgressView.progress = 0.0
        currentProgress = 0.0
        timerLabel.text = "\(formatDuration(currentProgress))"
        moveToNextSong()
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

