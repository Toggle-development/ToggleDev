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
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    var postArray = [OGPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraIV.image = UIImage.init(systemName: "camera.circle.fill")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        ///TabBar frame Height
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0.0
        
        /// FeedList tabBar Bottom Margin
        collectionViewHeight.constant = tabBarHeight

        /// for the first time load
        let visibleCellsInFrame = self.collectionView.indexPathsForVisibleItems
        playVideoOf(visibleCell: visibleCellsInFrame)
        
    }
}

//MARK: - Video Player Helping methods
extension MainFeedVC {
    
    fileprivate func playVideoOf(visibleCell: [IndexPath]) {
        
        let completeVisibleCellRow = getRowOfComplete(visibleCells: visibleCell) ?? -1
        print("visibleCellRow ---> ", completeVisibleCellRow)
        
        for (_,indexPath) in visibleCell.enumerated() {
            
            guard let videoCell = collectionView.cellForItem(at: indexPath) as? MainFeedCell else { return }
            
            if indexPath.section == completeVisibleCellRow {
                videoCell.playVideo()
            }else{
                videoCell.pauseVisibleVideos()
            }
        }
    }
    
    fileprivate func getRowOfComplete(visibleCells: [IndexPath]) -> Int? {
        for (_,indexPath) in visibleCells.enumerated() {
            if let cellRect = collectionView.layoutAttributesForItem(at: indexPath)?.frame {
                if collectionView.bounds.contains(cellRect) {
                    return indexPath.section
                }
            }
        }
        return nil
    }
}

//MARK: - UICollectionViewDataSource
extension MainFeedVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return postArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFeedCell", for: indexPath) as! MainFeedCell
        cell.model = postArray[indexPath.section]
        cell.layer.cornerRadius = 12

        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainFeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 8
        let height =  ( (width / 1.777) +  223.5)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { return .init(top: 4, left: 0, bottom: 4, right: 0) }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            /// passing all visible cells here
            self.playVideoOf(visibleCell: self.collectionView.indexPathsForVisibleItems)
            timer.invalidate()
        }
    }
}

