//
//  TickerTableViewCell.swift
//  PoloniexTicker
//
//  Created by ViXette on 10/08/2019.
//  Copyright © 2019 ViXette. All rights reserved.
//

import UIKit

class TickerTableViewCell: UITableViewCell {
    private var titleLabel = UILabel.initForTitle(size: 16, bold: true) 
    
    private var lastLabel = UILabel.initForTitle(size: 16, bold: true)

    private var highestLabel = UILabel.initForTitle(size: 13, bold: false)

    private var percentChangeLabel = UILabel.initForTitle(size: 13, bold: false) 

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var last: String? {
        didSet {
            lastLabel.text = last
        }
    }

    var highest: String? {
        didSet {
            highestLabel.text = highest
        }
    }

    var percentChange: String? {
        didSet {
            percentChangeLabel.text = percentChange
            percentChangeLabel.textColor = percentChange?.prefix(1) == "-" ? .red : .darkGray
        }
    }

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(titleLabel, lastLabel, highestLabel, percentChangeLabel)
        
        lastLabel.textAlignment = .center
        highestLabel.textAlignment = .right
        percentChangeLabel.textAlignment = .right
        
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        let padding = 12
        titleLabel.snp.makeConstraints { maker in
            if #available(iOS 11, *) {
                maker.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(padding)
            } else {
                maker.leading.equalToSuperview().offset(padding)
            }
            maker.centerY.equalToSuperview()
            maker.width.equalToSuperview().dividedBy(3)
        }
        
        lastLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.trailing)
            maker.centerY.equalToSuperview()
            maker.width.equalToSuperview().dividedBy(3)
        }
        
        highestLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(padding)
            if #available(iOS 11, *) {
                maker.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-padding)
            } else {
                maker.trailing.equalToSuperview().offset(-padding)
            }
            maker.width.equalToSuperview().dividedBy(3)
        }

        percentChangeLabel.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-padding)
            if #available(iOS 11, *) {
                maker.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-padding)
            } else {
                maker.trailing.equalToSuperview().offset(-padding)
            }
            maker.width.equalToSuperview().dividedBy(3)
        }

        super.updateConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title = ""
        last = ""
    }
}
