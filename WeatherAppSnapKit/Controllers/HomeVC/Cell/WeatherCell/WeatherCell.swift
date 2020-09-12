//
//  WeatherCell.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    lazy var contentStackView = UIStackView()
    lazy var labelsStackView = UIStackView()
    lazy var tempLabel = UILabel()
    lazy var dateLabel = UILabel()
    lazy var detailLabel = UILabel()
    lazy var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(model:WeatherModel?) {
        tempLabel.text = model?.main?.temp?.kelvinToCelcius()
        let unixTimestamp = model?.dt ?? 0
        dateLabel.text = unixTimestamp.dateFormatTime()
        
    }
    func setCellforCoreData(model:WeatherModel?,coreData:WeatherArray) {
        tempLabel.text = model?.main?.temp?.kelvinToCelcius()
        dateLabel.text = coreData.date
        titleLabel.text = coreData.day
        titleLabel.isHidden = false
    }
}
