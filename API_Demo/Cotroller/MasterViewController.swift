//
//  ViewController.swift
//  API_Demo
//
//  Created by Duc Anh on 12/4/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import UIKit



class MasterViewController: UITableViewController, UISearchResultsUpdating {
    
    var filterQuake = [QuakeInfo]()
    var dislayData = [QuakeInfo]()
    
    let search = UISearchController(searchResultsController: nil)
//    var quakeInfo: [QuakeInfo] = [QuakeInfo(mag: 4.7, place1: "27KM SE OF", place2: "Isangel Vanuatu", time1: "Jun 26, 2016", time2: "4:17 AM"),
//                                  QuakeInfo(mag: 4.8, place1: "28KM SES OF", place2: "Kute Indonesia", time1: "Jun 10, 2016", time2: "1: 11 AM"),
//                                  QuakeInfo(mag: 4.9, place1: "29KM SOS OF", place2: "Babe Thai Lan", time1: "Apr 16, 2016", time2: "9: 00 PM")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70
        updateUserInterface()
        DataServices.sharedInstance.loadInfo { (json) in
            self.filterQuake = json
            self.dislayData = self.filterQuake
            self.tableView.reloadData()
        }
       
        // Do any additional setup after loading the view, typically from a nib.
        searchBar()
    }
    
    // internet
    func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            view.backgroundColor = .white
        case .wifi:
            view.backgroundColor = .green
        case .wwan:
            view.backgroundColor = .yellow
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
    }
    func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    func searchBar() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        search.isActive = true
        definesPresentationContext = true
    }
    
}

// MARK: - UITableViewDataSource

extension MasterViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dislayData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
//        configureCell(cell: cell, forRowAt: indexPath)
        let quakes = dislayData[indexPath.row]
        cell.magQR.text = String(quakes.mag)
        cell.place1.text = quakes.distainsString
        cell.place2.text = quakes.locationName
        cell.time1.text = quakes.dateString
        cell.time2.text = quakes.timeString
        return cell
    }
    
//    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.textLabel?.text = String(indexPath.row)
//    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetaiViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.urlString = String(dislayData[indexPath.row].url)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
      
        guard let searchText = searchController.searchBar.text else { return }
        dislayData = searchText.isEmpty ? (filterQuake) : (filterQuake.filter({ (data) -> Bool in
            return data.place.lowercased().contains(searchText.lowercased())
        }))
        tableView.reloadData()
 
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataServices.sharedInstance.selectedQuake = filterQuake[indexPath.row]
    }
}
