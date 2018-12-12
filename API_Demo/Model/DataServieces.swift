//
//  DataServieces.swift
//  API_Demo
//
//  Created by Duc Anh on 12/4/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>
class DataServices {
   static var sharedInstance = DataServices()
    var uRL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson"
    var quakeInfo: [QuakeInfo] = []
    var arrDetail: [Any] = []
    var selectedQuake: QuakeInfo?
    
    func makeDataTaskRequest(urlString: String, completeBlock:  @escaping (JSON) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, respone, error) in
            guard error == nil else {
                return
            }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) else {
                return
            }
            guard let json = jsonObject as? JSON else {
                return
            }
            DispatchQueue.main.async {
                completeBlock(json)
  
            }
        }
        task.resume()
    }
    
    func loadInfo(completeHandler: @escaping ([QuakeInfo]) -> Void) {
       quakeInfo = []
        makeDataTaskRequest(urlString: uRL) { [unowned self] json in
            guard let dictFeatures = json["features"] as? [JSON] else {return}
            for featuresJson in dictFeatures {
                if let propertiesJson = featuresJson["properties"] as? JSON {
                    if let quake = QuakeInfo(dict: propertiesJson) {
                        self.quakeInfo.append(quake)
                    }
                }
            }
//            print(self.quakeInfo)
            completeHandler(self.quakeInfo)
        }
    }
    
}
