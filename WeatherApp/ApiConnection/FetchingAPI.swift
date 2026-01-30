//
//  FetchingAPI.swift
//  WeatherApp
//
//  Created by rentamac on 1/29/26.
//

import Foundation
enum FetchingAPI{
    
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist is not found")
        }
        return dict
    }()
    
    static let baseURL : String = {
        guard let urlString = FetchingAPI.infoDict["baseURL"] as? String else{
            fatalError("baseURL is not found")
        }
        
//        guard let url = URL(string: urlString) else{
//            fatalError("baseURL is invalid")
//        }
        return urlString
    }()
    
    static let addURL : String = {
        guard let urlString = FetchingAPI.infoDict["addURL"] as? String else{
            fatalError("addURL is not found")
        }
        
//        guard let url = URL(string: urlString) else{
//            fatalError("baseURL is invalid")
//        }
        return urlString
    }()
    
    static let path : String = {
        guard let pathString = FetchingAPI.infoDict["path"] as? String else{
            fatalError("path is not found")
        }
        
        return pathString
    }()
    
    static let addpath : String = {
        guard let pathString = FetchingAPI.infoDict["addpath"] as? String else{
            fatalError("addpath is not found")
        }
        
        return pathString
    }()
}
