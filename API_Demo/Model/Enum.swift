//
//  Enum.swift
//  API_Demo
//
//  Created by tran duc anh on 5/6/19.
//  Copyright © 2019 Duc Anh. All rights reserved.
//

import Foundation

enum SummaryQuake: Int {
    case mag
    case cdi
    case mmi
    case alert
    case evenTime
    case depth
    case latitude
    case longitude
    case felt
    case place
    
    func needToShow(dataDetail: QuakeInfo?) -> Bool {
        switch self {
        case .mag :
            return dataDetail?.mag != nil
        case .cdi:
            return dataDetail?.cdi != nil
        case .mmi:
            return dataDetail?.mmi != nil
        case .alert:
            return !checkStringNullOrEmpty(string: dataDetail?.alert)
        case .evenTime:
            return !checkStringNullOrEmpty(string: dataDetail?.eventTime)
        case .depth:
            return !checkStringNullOrEmpty(string: dataDetail?.depth)
        case .latitude:
            return !checkStringNullOrEmpty(string: dataDetail?.latitude)
        case .longitude:
            return !checkStringNullOrEmpty(string: dataDetail?.longitude)
        case .felt:
            return dataDetail?.felt != nil
        case .place:
            return !checkStringNullOrEmpty(string: dataDetail?.distainsString) || !checkStringNullOrEmpty(string: dataDetail?.locationName)
        }
    }
    private func checkStringNullOrEmpty(string: String?) -> Bool {
        guard let aString = string else {return true}
        if aString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
}
