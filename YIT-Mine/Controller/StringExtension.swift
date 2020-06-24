//
//  StringExtension.swift
//  YIT-Mine
//
//  Created by moran levi on 09/06/2020.
//  Copyright © 2020 M.Levi's. All rights reserved.
//


import Foundation

extension String{
    func replacingSpaceFromUrl() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
    }
}
