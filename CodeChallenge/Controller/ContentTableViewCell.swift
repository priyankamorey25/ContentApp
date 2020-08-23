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
   
    let idLbl = UILabel()
    let dateLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        idLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgUser)
        contentView.addSubview(idLbl)
        contentView.addSubview(dateLbl)
        let viewsDict = [
            "image": imgUser,
            "message": idLbl,
            "labTime": dateLbl,
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
            idLbl.text = "Id: " + model.id
            dateLbl.text = "Date " + (model.date ?? "")
        }else {
            idLbl.text = "Id: " + (coreDataModel?.id ?? "")
            dateLbl.text = "Date: " + (coreDataModel?.date ?? "")
        }
    }
    
}
