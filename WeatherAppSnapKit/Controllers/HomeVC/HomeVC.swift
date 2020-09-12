//
//  HomeVC.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class HomeVC: UIViewController {
    lazy var stackView = UIStackView()
    lazy var tableView = UITableView()
    lazy var saveButton = UIButton()
    lazy var viewModel = HomeVM.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPHome()
    }
    
}
extension HomeVC: HomeVMDelegates {
    func getWeather() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func saveToDatabase() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension HomeVC: LocationManagerDelegates {
    func recievedLocation() {
        viewModel.getWeather()
    }
}
