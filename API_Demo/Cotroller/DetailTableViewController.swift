//
//  SummaryTableViewController.swift
//  API_Demo
//
//  Created by Duc Anh on 12/7/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
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
    
    var dataDetail : QuakeInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        DataServices.sharedInstance.selectedQuake?.loadDataDetail { [unowned self] quakeInfo in
            self.dataDetail = quakeInfo
            self.magLabel.text = "Mag: \(quakeInfo.mag)"
            self.cdiLabel.text = "Cdi: \(quakeInfo.cdi ?? 0)"
            self.mmiLabel.text = "Mmi: \(quakeInfo.mmi ?? 0)"
            self.alertLabel.text = "Alert: \(quakeInfo.alert ?? "")"
            self.evenTimeLabel.text = "EventTime: \(quakeInfo.eventTime ?? "")"
            self.depthLabel.text = "Depth: \(quakeInfo.depth ?? "")"
            self.latitudeLabel.text = "Latitude: \(quakeInfo.latitude ?? "")"
            self.longitudeLabel.text = "Longitude: \(quakeInfo.longitude ?? "")"
            self.feltLabel.text = "Felt: \(quakeInfo.felt ?? 0)"
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
