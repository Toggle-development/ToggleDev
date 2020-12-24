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
        //setup player properties (will be moved to different class)
        player.volume = 0
        player.play()
        
        //create image thumbnail frame
        let imgViewThumbnail: UIImageView = UIImageView.init(frame: layer.bounds)
        
        //assign properties to layer and imageViewThumbnail
        self.backgroundColor = .clear
        imgViewThumbnail.contentMode = .scaleAspectFit
        self.addSubview(imgViewThumbnail)
        createThumbnailImage(for: imgViewThumbnail)
        self.addSubview(imgViewThumbnail)

        // Add the player to our Player Layer
        playerLayer.player = player
        playerLayer.videoGravity = .resize // Resizes content to fill whole video layer.
        playerLayer.backgroundColor = UIColor.black.cgColor
                
        previewTimer = Timer.scheduledTimer(withTimeInterval: previewLength, repeats: true, block: { (timer) in
            player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
        })
        
        layer.addSublayer(playerLayer)
    }
    
    func createThumbnailOfVideoFromRemoteUrl(url: String, completion: @escaping(_ image: UIImage?)->Void){
        let imageWidth = self.bounds.width
        let imageHeight = self.bounds.height
        DispatchQueue.global(qos: .userInitiated).async {
            let asset = AVAsset(url: URL(string: url)!)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            assetImgGenerate.maximumSize = CGSize(width: imageWidth, height: imageHeight)
            let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                DispatchQueue.main.async {
                    completion(thumbnail)
                }
            } catch {
              print(error.localizedDescription)
              completion(nil)
            }
        }
    }
    
    func createThumbnailImage(for imageView: UIImageView) {
        if let AVPlayerURL = ((player.currentItem?.asset) as? AVURLAsset)?.url {
            self.createThumbnailOfVideoFromRemoteUrl(url: AVPlayerURL.absoluteString) { (image) in
                if let image = image {
                    imageView.image = image
                } else {
                    print("unable to generate thumbnail for url \(AVPlayerURL)")
                }
            }
        }
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented") }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
