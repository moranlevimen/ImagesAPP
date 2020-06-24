//
//  DataManager.swift
//  YIT-Mine
//
//  Created by moran levi on 09/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//

import Foundation

class DataManager {
    
    private static var sharedInstance: DataManager?

    private init(){}

    
    static func getSharedInstance()-> DataManager{
        if DataManager.sharedInstance == nil{
            DataManager.sharedInstance = DataManager()
        }
        return DataManager.sharedInstance!
    }
    
    private var imagesInfo:[InfoImage] = []
    
    func setImagesInfo(imagesInfo:[InfoImage]){
        for item in imagesInfo {
            self.imagesInfo.append(item)
        }
    }
    func clearImagesInfo(){
        self.imagesInfo = []
    }
    
    func getImagesInfo() -> [InfoImage]{
        return self.imagesInfo
    }
    
}
