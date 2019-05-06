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
    
    var dataDetail : QuakeDetail!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        guard let detailData = DataServices.sharedInstance.selectedQuake else { return }
        DataServices.sharedInstance.loadDataDetail(from: detailData.detail) { detail in
            self.dataDetail = detail
            self.magLabel.text = "Mag: \(detailData.mag)"
            self.cdiLabel.text = "Cdi: \(detail.cdi)"
            self.mmiLabel.text = "Mmi: \(detail.mmi)"
            self.alertLabel.text = "Alert: \(detail.alert)"
            self.evenTimeLabel.text = "EventTime: \(detail.eventTime)"
            self.depthLabel.text = "Depth: \(detail.depth)"
            self.latitudeLabel.text = "Latitude: \(detail.latitude)"
            self.longitudeLabel.text = "Longitude: \(detail.longitude)"
            self.feltLabel.text = "Felt: \(detail.felt)"
            self.placeLabel.text = "Place: \(detailData.distainsString) \(detailData.locationName)"
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
