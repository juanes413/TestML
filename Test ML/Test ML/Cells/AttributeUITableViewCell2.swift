//
//  AttributesUITableViewCell.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 16/11/21.
//

import UIKit

class AttributeUITableViewCell2: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let labelName: UILabel = {
        let labelName = UILabel()
        labelName.textAlignment = .left
        labelName.numberOfLines = 0
        labelName.font = UIFont.boldSystemFont(ofSize: 13)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        return labelName
    }()

    let labelValue: UILabel = {
        let labelValue = UILabel()
        labelValue.textAlignment = .left
        labelValue.font = UIFont.systemFont(ofSize: 13)
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.numberOfLines = 0
        return labelValue
    }()
    
    private func layoutUI() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(labelName)
        contentView.addSubview(labelValue)
    }
    
    private func setConstraints() {
    
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            //labelName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
             
            labelValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            //labelValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            labelValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            labelValue.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 8),
            NSLayoutConstraint(item: labelName, attribute: .width, relatedBy: .equal, toItem: labelValue, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: labelName, attribute: .height, relatedBy: .equal, toItem: labelValue, attribute: .height, multiplier: 1.0, constant: 0.0)
        ])
    }
    
}
