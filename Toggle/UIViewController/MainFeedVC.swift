//
//  MainFeedVC.swift
//  Toggle
//
//  Created by Furqan Ahmad on 19/12/2020.
//

import UIKit
import AnimatedCollectionViewLayout
import AVFoundation

class MainFeedVC: UIViewController, UIScrollViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var cameraIV: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var postArray = [OGPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ParallaxAttributesAnimator()
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        
        cameraIV.image = UIImage.init(systemName: "camera.circle.fill")
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playVideo(visibleCell: collectionView.visibleCells.first ?? UICollectionViewCell())
    }
    
    func playVideo(visibleCell:UICollectionViewCell){
        guard let videoCell = (visibleCell as? MainFeedCell) else { return }
        videoCell.videoPlayerView.player?.play()
    }
    
}
extension MainFeedVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFeedCell", for: indexPath) as! MainFeedCell
        cell.tag = indexPath.row
        cell.configure(with: postArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let videoCell = (cell as? MainFeedCell) else { return };
//        videoCell.videoPlayerView.player?.play()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        guard let videoCell = (cell as? MainFeedCell) else { return }
        videoCell.videoPlayerView.player?.removeObserver(videoCell, forKeyPath: "currentItem.loadedTimeRanges")
        NotificationCenter.default.removeObserver(videoCell, name: .AVPlayerItemDidPlayToEndTime, object: videoCell.videoPlayerView.player?.currentItem)
        videoCell.videoPlayerView.player?.pause()
//        videoCell.videoPlayerView.player = nil
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainFeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

