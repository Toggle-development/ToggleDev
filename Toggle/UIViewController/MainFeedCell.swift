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
    @IBOutlet weak var videoPlayerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var thumbnailIV: UIImageView!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    private var isAlreadyPlaying = true
    
    var model : OGPost?{
        didSet{
            userIV.image = UIImage.init(systemName: "person.circle.fill")
            likeButton.setImage(UIImage.init(systemName: "heart"), for: .normal)
            commentButton.setImage(UIImage.init(systemName: "message"), for: .normal)
            shareButton.setImage(UIImage.init(systemName: "arrowshape.turn.up.right"), for: .normal)
            userNameLbl.text = model?.postOwner
            videoPlayerViewHeight.constant = self.frame.width / (1.777)
        }
    }
    
    func playVideo(){
        self.setupVideo(videoURL: model?.videoURL ?? "")
    }
    
    private func setupVideo(videoURL: String) {
        
        self.loader.startAnimating()
        self.thumbnailIV.isHidden = true
        
        guard let videoURL = URL(string: videoURL) else { return }
        
        videoPlayerView.player = AVPlayer(url: videoURL)
        
        // creating new player here
        videoPlayerView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPlayerView.playerLayer.zPosition = -1
        videoPlayerView.playerLayer.backgroundColor = UIColor.clear.cgColor
        
        videoPlayerView.player?.seek(to: CMTime(seconds: 5, preferredTimescale: CMTimeScale(1)))
        videoPlayerView.player?.play()
        videoPlayerView.playerLayer.backgroundColor = UIColor.clear.cgColor
        videoPlayerView.backgroundColor = UIColor.clear
        
        // setting the observer, it will call when video gets ended
        NotificationCenter.default.addObserver(self, selector:#selector(resStartVideo),name: .AVPlayerItemDidPlayToEndTime, object: videoPlayerView.player?.currentItem)
        
        videoPlayerView.player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func stopPlayback() {
        print("Stop playing")
        self.videoPlayerView.player?.pause()
    }
    
    func startPlayback() {
        print("Start playing")
        self.videoPlayerView.player?.play()
    }
    
    @objc func resStartVideo(){
        videoPlayerView.player?.seek(to: CMTime(seconds: 5, preferredTimescale: CMTimeScale(1)))
        videoPlayerView.player?.play()
    }
    
    @IBAction func playerBtnTapped(_ sender: Any) {
        isAlreadyPlaying ? stopPlayback() : startPlayback()
        isAlreadyPlaying = !isAlreadyPlaying
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                print("playing --> ", self.model?.postOwner ?? "")
            }
        }
    }
    
    func pauseVisibleVideos(){
        if videoPlayerView.player != nil && videoPlayerView.player?.rate != 0{
            
            videoPlayerView.player?.removeObserver(self, forKeyPath: "currentItem.loadedTimeRanges")
            
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: videoPlayerView.player?.currentItem)
            
            videoPlayerView.player?.pause()
        }
        
        self.thumbnailIV.isHidden = false
    }
}
