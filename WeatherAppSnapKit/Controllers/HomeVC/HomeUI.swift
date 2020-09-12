//
//  HomeUI.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import SnapKit
enum Sections:Int, CaseIterable {
    case weather = 0
    case savedWeather
}
extension HomeVC {
    
    func setUPHome(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        tableView.register(LoadingCell.self, forCellReuseIdentifier: "LoadingCell")
        
        stackView.setupStackView(alignment: .fill, distribution: .fill, axis: .vertical, spacing: 0, view: view)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        stackView.addArrangedSubview(views: [tableView,setupButton()])
        
        navigationItem.title = "Weather"
        viewModel.delegate = self
        LocationManager.shared.delegate = self
    }
    fileprivate func setupButton() -> UIView {
        let view = UIView()
        view.addSubview(saveButton)
        view.dropShadow()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(80)
        }
        saveButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.addTarget(self, action: #selector(didsaveButtonTapped), for: .touchUpInside)
        
        return view
    }
    @objc fileprivate func didsaveButtonTapped() {
        viewModel.save()
    }
  
}
// MARK: UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.showLoading {
            return 1
        } else {
            return 2
        }
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Sections(rawValue: section)
        if section == .weather {
            return 1
        } else {
            return viewModel.getCoreDataCount()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.showLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            return cell
        }
        let section = Sections(rawValue: indexPath.section)
        switch section {
        case .weather:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
            cell.setCell(model: viewModel.model)
            return cell
        case .savedWeather:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
            cell.setCellforCoreData(model: viewModel.model, coreData: viewModel.getCoreData(indexPath: indexPath))
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       let section = Sections(rawValue: section)
        if section == .weather {
            return "Current Weather"
        } else if section == .savedWeather {
            if viewModel.getCoreDataCount() > 0 {
              return "Saved Weather"
            }
        }
        return ""
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel.showLoading {
            return 0
        } else {
            return 40
        }
    }
}
// MARK: UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let section = Sections(rawValue: editActionsForRowAt.section)
        if section == .weather {
            return nil
        }
        let update = UITableViewRowAction(style: .normal, title: "Update") { action, index in
            AlertManager.shared.showAlertWithText(title: "Update Title", buttonTitle: "Update") { (text) in
                guard text != "" else {return}
                self.viewModel.getCoreData(indexPath: index).setValue(text, forKey: "day")
                self.viewModel.saveData()
            }
        }
        update.backgroundColor = .orange
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.viewModel.coreDataModel.delete(self.viewModel.getCoreData(indexPath: index))
            self.viewModel.removeCoreData(indexPath: index)
            self.viewModel.saveData()
        }
        delete.backgroundColor = .red
        
        return [delete, update]
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
