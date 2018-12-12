//
//  SummaryTableViewController.swift
//  API_Demo
//
//  Created by Duc Anh on 12/7/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import UIKit

class SummaryTableViewController: UITableViewController {

    var dataDetail : QuakeInfo?
    
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
    
    
    @IBOutlet weak var magLabel: UILabel!
    @IBOutlet weak var cdiLabel: UILabel!
    @IBOutlet weak var mmiLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var evenTimeLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var feltLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataServices.sharedInstance.selectedQuake?.loadDataDetail { [unowned self] quakeInfo in
            self.dataDetail = quakeInfo
            
            self.magLabel.text = "Mag: \(self.dataDetail!.mag)"
            if let cdi = self.dataDetail?.cdi {
                self.cdiLabel.text = "Cdi: \(cdi)"
            }
            if let mmi = self.dataDetail?.mmi {
                self.mmiLabel.text = "Mmi: \(mmi)"
            }
            self.alertLabel.text = "Alert: \(self.dataDetail?.alert ?? "")"
            
            if let evenTime = self.dataDetail?.eventTime {
                self.evenTimeLabel.text = "EventTime: \(evenTime)"
            }
            if let depth = self.dataDetail?.depth {
                self.depthLabel.text = "Depth: \(depth)"
            }
            if let latitude = self.dataDetail?.latitude {
                self.latitudeLabel.text = "Latitude: \(latitude)"
            }
            if let longitude = self.dataDetail?.longitude {
                self.longitudeLabel.text = "Longitude: \(longitude)"
            }
            if let felt = self.dataDetail?.felt {
                self.feltLabel.text = "Felt: \(felt)"
            }
            self.placeLabel.text = "Place: \(self.dataDetail!.distainsString) \(self.dataDetail!.locationName)"
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cellType = SummaryQuake(rawValue: indexPath.row) {
            return cellType.needToShow(dataDetail: dataDetail) ? UITableView.automaticDimension : 0
        } else {
            return 0
        }
    }
    
}
