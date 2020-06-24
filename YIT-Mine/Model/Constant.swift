//
//  Constant.swift
//  YIT-Mine
//
//  Created by moran levi on 09/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//

import Foundation
class Constant{
        static let searchKey = "searchKey"
        enum AlertText:String {
            case noImagesFound = "No Images Found"
        }
        
        static func getSearchUrl(searchString:String,pageNumberStr:String) -> String {
            let searchUrl = "https://pixabay.com/api/?q=\(searchString)&key=6814610-cd083c066ad38bb511337fb2b&page=\(pageNumberStr)".replacingSpaceFromUrl()
            return searchUrl
        }
        enum ApiError:Error {
            case serverError
        }
        enum Identifier:String {
            case imageCellId = "imageCellId"
            case collectionViewCell = "ImageCell"
            case swipingVCSegue = "swipingVCSegue"
        }
    }
