//
//  Tests.swift
//  Tests
//
//  Created by Duc Anh on 12/13/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import XCTest
@testable import API_Demo
class Tests: XCTestCase {

    func testQuakeInitializationSucceeds() {
        let zeroPlaceQuake = QuakeInfo(mag: 5, place: "Reykjanes Ridge", timeInterval: 1544768250110, url: "https://earthquake.usgs.gov/earthquakes/eventpage/us2000itht", detail: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/us2000itht.geojson")
        XCTAssertNotNil(zeroPlaceQuake)

        let potisivePlaceQuake = QuakeInfo(mag: 4.8, place: "West Chile Rise", timeInterval: 1544766417430, url: "https://earthquake.usgs.gov/earthquakes/eventpage/us2000ithj", detail: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/us2000ithj.geojson")
        XCTAssertNotNil(potisivePlaceQuake)
    }
    
    func testQuakeInitializationFails() {
        let negativePlaceQuake = QuakeInfo(mag: 0, place: "3km NNE of Mamasa, Indonesia", timeInterval: 0, url: "", detail: "")
        XCTAssertNil(negativePlaceQuake)
        
        let emptyPlaceQuake = QuakeInfo(mag: 0, place: "", timeInterval: 0, url: "", detail: "")
        XCTAssertNil(emptyPlaceQuake)
        
        
    }
    
    
}
