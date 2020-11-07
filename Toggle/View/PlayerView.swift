//
//  PlayerView.swift
//  Toggle
//
//  Created by Walid Rafei on 11/6/20.
//
import UIKit
import AVFoundation
import AVKit

class PlayerView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var previewTimer:Timer?
    private var previewLength:Double
    private var player: AVPlayer
    
    init(player: AVPlayer, frame: CGRect, previewLength:Double) {
        self.previewLength = previewLength // can be used to limit how long the video is
        self.player = player
        super.init(frame: frame)
        
        // Create the video player using the URL passed in.
        //let player = AVPlayer(url: url)
        player.volume = 0 // Will play audio if you don't set to zero
        player.play() // Set to play once created
        
        // Add the player to our Player Layer
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill // Resizes content to fill whole video layer.
        playerLayer.backgroundColor = UIColor.black.cgColor
        
        previewTimer = Timer.scheduledTimer(withTimeInterval: previewLength, repeats: true, block: { (timer) in
            player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
        })
        
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented") }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
