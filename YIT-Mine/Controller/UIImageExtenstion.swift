//
//  UIImageExtenstion.swift
//  YIT-Mine
//
//  Created by moran levi on 21/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    // Download images from url
    func loadImageFromUrl(url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
