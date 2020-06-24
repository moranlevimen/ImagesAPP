//
//  ServerManager.swift
//  YIT-Mine
//
//  Created by moran levi on 09/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager{
    
    private static var sharedInstance : ServerManager?
    
    static func getSharedInstance() -> ServerManager{
        if ServerManager.sharedInstance == nil{
            ServerManager.sharedInstance = ServerManager()
        }
        return ServerManager.sharedInstance!
        
    }
    
    private init(){}
    

    func getImages(searchKey:String,pageNum:String,completionHandler:@escaping(Result<[InfoImage]>)->()) {
    guard let validUrl = URL(string: Constant.getSearchUrl(searchString: searchKey, pageNumberStr: pageNum)) else { return }
     Alamofire.request(validUrl,method: .get).responseData { (response) in
         
         if let totalHitsData = response.data{
             do {
                 let totalHits:SerachNumber = try JSONDecoder().decode(SerachNumber.self, from: totalHitsData)
                 if let imagesInfo = totalHits.hits {
                     completionHandler(.success(imagesInfo))
                    print(imagesInfo)
                 }
                 else{
                    print("error in image load")
                                      }
             }
             catch  {
                print("server error - network problems")
             }
         }
         else{
             print("server error 2")
         }
     }
 }

}
