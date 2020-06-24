//
//  ImageCell.swift
//  YIT-Mine
//
//  Created by moran levi on 21/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//

import UIKit
//ImageCollectionViewCell
//ImageCell
class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var cellFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    func setCell(infoImage: InfoImage){
        if let urlString = infoImage.previewURL{
            self.imageView.loadImageFromUrl(url: URL(string: urlString)!)
            guard let width = infoImage.previewWidth,
                let height = infoImage.previewHeight else{
                    return
            }
            self.cellFrame.size = CGSize(width: width, height: height)
    //
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
           setNeedsLayout()
           layoutIfNeeded()
       layoutAttributes.frame = self.cellFrame
           return layoutAttributes
       }

}
