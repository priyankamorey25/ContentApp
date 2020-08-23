//
//  ContentTableViewCell.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 07/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    let imgUser = UIImageView()
    let labUserName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        labUserName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labTime.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgUser)
        contentView.addSubview(labUserName)
        contentView.addSubview(labMessage)
        contentView.addSubview(labTime)
        let viewsDict = [
            "image": imgUser,
            "username": labUserName,
            "message": labMessage,
            "labTime": labTime,
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[labTime]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[message]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI (model:ContentListModelElement?,coreDataModel: Content?) {
        if let model = model{
            labMessage.text = "Id: " + model.id
            labTime.text = "Date " + (model.date ?? "")
        }else {
            labMessage.text = "Id: " + (coreDataModel?.id ?? "")
            labTime.text = "Date: " + (coreDataModel?.date ?? "")
        }
    }
    
}
