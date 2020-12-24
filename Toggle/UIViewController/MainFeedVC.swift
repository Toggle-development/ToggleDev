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
        
        cameraIV.image = UIImage.init(systemName: "camera.circle.fill")
        
        /// TODO: - Need proper fix for this
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
            
            if indexPath.row == completeVisibleCellRow {
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
                    return indexPath.row
                }
            }
        }
        return nil
    }
}

//MARK: - UICollectionViewDataSource
extension MainFeedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFeedCell", for: indexPath) as! MainFeedCell
        cell.model = postArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        /// passing all visible cells here
        playVideoOf(visibleCell: self.collectionView.indexPathsForVisibleItems)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainFeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = (50 + ( width / 1.777) +  150)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { return .zero }
}

