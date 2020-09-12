//
//  WeatherCellUI.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension WeatherCell {
    func setupCell(){
        self.selectionStyle = .none
        setupContentStackView()
    }
    
    fileprivate func setupContentStackView() {
        let view = UIView()
        contentStackView.setupStackView(alignment: .fill, distribution: .fill, axis: .horizontal, spacing: 10, view: view)
        contentView.addSubview(view)
        view.backgroundColor = .lightGray
        view.snp.makeConstraints { (make) in
          //  make.height.equalTo(120)
            make.edges.equalToSuperview().inset(8)
        }
        view.dropShadow(cornerRadius: 10)
        contentStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.top.equalToSuperview()
        }
        contentStackView.addArrangedSubview(views: [setupLabelStackView(),setupDetailLabel()])
    }
    fileprivate func setupLabelStackView() -> UIView{
        let view = UIView()
        labelsStackView.setupStackView(alignment: .fill, distribution: .fillEqually, axis: .vertical, spacing: 0, view: view)
        labelsStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        labelsStackView.addArrangedSubview(views: [setupTitleLabel(),setupTempLabel(),setupDateLabel()])
        return view
    }
    fileprivate func setupTempLabel() -> UIView {
        let view = UIView()
        view.addSubview(tempLabel)
        tempLabel.font = UIFont.systemFont(ofSize: 20)
        tempLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.edges.equalToSuperview()
        }
        return view
    }
    fileprivate func setupDateLabel() -> UIView {
        let view = UIView()
        view.addSubview(dateLabel)
        dateLabel.numberOfLines = 0
        dateLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }
    fileprivate func setupDetailLabel() -> UIView {
        let view = UIView()
        view.addSubview(detailLabel)
        detailLabel.text = "Detail >"
        detailLabel.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal) //detail label i sağ tarafa baskılaması için
        detailLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }
    func setupTitleLabel() -> UILabel {
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.isHidden = true
        return titleLabel
    }
}
