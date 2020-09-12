//
//  LoadingCellUI.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension LoadingCell {
    func setupCell() {
        contentView.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(16)
        }
    }
}
