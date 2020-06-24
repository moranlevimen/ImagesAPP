//
//  FullImageVC.swift
//  YIT-Mine
//
//  Created by moran levi on 24/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//

import UIKit

class FullImageVC: UIViewController{
    
    @IBOutlet weak var fullImage: UIImageView!
    
    var index:Int = 0
    
    override func viewDidLoad() {
        screenConfig()
        presentImage()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func shareImg(_ sender: UIButton) {
        let imageShared = [fullImage]
        let activityViewController = UIActivityViewController(activityItems: imageShared as [Any] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func presentImage() {
        guard let stringUrl = DataManager.getSharedInstance().getImagesInfo()[self.index].largeImageURL else { return}
        guard let imageUrl = URL(string: stringUrl) else { return}
        self.fullImage.loadImageFromUrl(url: imageUrl)
    }
    
    func screenConfig() {
        imageViewConfig()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func imageViewConfig()  {
        self.fullImage.contentMode = .scaleAspectFit
        self.fullImage.isUserInteractionEnabled = true
        let directionsArray: [UISwipeGestureRecognizer.Direction] = [.right, .left]
        for direction in directionsArray {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action:  #selector(respondToSwipeGesture))
            swipeGesture.direction = direction
            self.fullImage.addGestureRecognizer(swipeGesture)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
           
            switch swipeGesture.direction {
                
            case .right:
                self.index = self.index == DataManager.getSharedInstance().getImagesInfo().count - 1 ? 0 : self.index + 1
                presentImage()
                
            case .left:
                self.index = self.index == 0 ? DataManager.getSharedInstance().getImagesInfo().count - 1 : self.index - 1
                presentImage()
          
            default:
                break
            }
        }
    }
}
