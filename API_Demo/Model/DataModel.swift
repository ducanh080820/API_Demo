//
//  DataModel.swift
//  API_Demo
//
//  Created by Duc Anh on 12/4/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import Foundation

class QuakeInfo {
    var mag: Double
    var place: String
    var distainsString: String
    var locationName: String
    var dateString: String
    var timeString: String
    var url: String
    var detail: String
    
    var felt: Double?
    var cdi: Double?
    var mmi: Double?
    var alert: String?
    
    var eventTime: String?
    var latitude: String?
    var longitude: String?
    var depth: String?
    
    init(mag: Double, place: String, timeInterval: TimeInterval, url: String, detail: String) {
        self.mag = mag
        self.place = place
        self.url = url
        self.detail = detail
        
                if place.contains(" of ") {
                    let placeDetail = place.components(separatedBy: " of ")
                    distainsString = (placeDetail.first ?? "") + " OF"
                    locationName = placeDetail.last ?? ""
                } else {
                    self.distainsString = "NEAR THE"
                    self.locationName = place
        }
        
        let dataForMater = DateFormatter()
        dataForMater.timeStyle = .short
        self.timeString = dataForMater.string(from: Date(timeIntervalSince1970: timeInterval * 1/1000))
        dataForMater.timeStyle = .none
        dataForMater.dateStyle = .medium
        self.dateString = dataForMater.string(from: Date(timeIntervalSince1970: timeInterval * 1/1000))
        
    }
    
   convenience init?(dict: JSON) {
        guard let mag = dict["mag"] as? Double else {return nil}
        guard let place = dict["place"] as? String else {return nil}
        guard let timeInterval = dict["time"] as? TimeInterval else {return nil}
        guard let url = dict["url"] as? String else {return nil}
        guard let detail = dict["detail"] as? String else {return nil}
        self.init(mag: mag, place: place, timeInterval: timeInterval, url: url, detail: detail)
    }
    
    func loadDataDetail(completionHandler: @escaping (QuakeInfo) -> Void) {
        DataServices.sharedInstance.makeDataTaskRequest(urlString: detail) { (dictDetail) in
            guard let dictDet = dictDetail["properties"] as? JSON else {return}
            let cdi = dictDet["cdi"] as? Double
            let mmi = dictDet["mmi"] as? Double
            let alert = dictDet["alert"] as? String
            let felt = dictDet["felt"] as? Double
            self.felt = felt
            self.cdi = cdi
            self.mmi = mmi
            self.alert = alert
            
            guard let dictProducts = dictDet["products"] as? JSON else {return}
            guard let arrOrigin = dictProducts["origin"] as? [JSON] else {return}
            guard let dictpropertiesOfOrigin = arrOrigin[0]["properties"] as? JSON else {return}
            
            if let evenTime = dictpropertiesOfOrigin["eventtime"]  as? String {
                var convertEventTime = evenTime
                convertEventTime = convertEventTime.replacingOccurrences(of: "T", with: " ")
                convertEventTime = convertEventTime.components(separatedBy: ".").first!
                self.eventTime = convertEventTime + " (UTC)"
            }
            
            if let depth = dictpropertiesOfOrigin["depth"] as? String {
                self.depth = depth + " Km"
            }
            
            guard let latitude = dictpropertiesOfOrigin["latitude"] as? String else {return}
            guard let longitude = dictpropertiesOfOrigin["longitude"] as? String else {return}
            
            // doi toa do
            func convertCoodinate(latitude: String, longitude: String) {
                if let latitudeDouble = Double(latitude) {
                    self.latitude = String(format: "%.3f°%@", abs(latitudeDouble), latitudeDouble >= 0 ? "N" : "S") // kieu dinh dang, gia tri tuyet doi.
                }
                if let longitudeDouble = Double(longitude) {
                    self.longitude = String(format: "%.3f°%@", abs(longitudeDouble), longitudeDouble >= 0 ? "N" : "S")
                }
            }
            convertCoodinate(latitude: latitude, longitude: longitude)
            completionHandler(self)
            
        }
    }
}
