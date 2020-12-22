//
//  MainFeedCell.swift
//  Toggle
//
//  Created by Furqan Ahmad on 19/12/2020.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self;
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer;
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player;
        }
        set {
            playerLayer.player = newValue;
        }
    }
}

class MainFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var videoPlayerView: VideoPlayerView!
    @IBOutlet weak var thumbnailIV: UIImageView!
    
    private var isAlreadyPlaying = true
    
    public func configure(with model: OGPost) {
        
        loader.startAnimating()
        
        guard let videoURL = URL(string: model.videoURL) else { return }
        let player         = AVPlayer(url: videoURL)
        
        videoPlayerView.playerLayer.frame        = self.frame
        videoPlayerView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPlayerView.playerLayer.player       = player
        
        /// play video for 60 seconds max, even if video is longer than that
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { (timer) in
            player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
        })
        
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func stopPlayback() {
        print("Stop playing")
        self.videoPlayerView.player?.pause()
    }
    
    func startPlayback() {
        print("Start playing")
        self.videoPlayerView.player?.play()
    }
    
    @IBAction func playerBtnTapped(_ sender: Any) {
        isAlreadyPlaying ? stopPlayback() : startPlayback()
        isAlreadyPlaying = !isAlreadyPlaying
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                print("playing")
            }
        }
    }
}
