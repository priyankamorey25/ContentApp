//
//  ContentDetailViewController.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 23/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import UIKit
import SnapKit
class ContentDetailViewController: UIViewController {
    var contentdetail :ContentListModelElement?
    var coreContent : Content?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    lazy var snapView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.layer.opacity = 0.7
        return view
    }()
    
    
    lazy var snapImg: UIImageView = {
        let img = UIImageView()
        if appDelegate.reachability.connection == .unavailable{
            if let url = URL(string: coreContent?.data ?? "") {
                img.load(url:url)}
        }else{
            
            if let url = URL(string:contentdetail?.data ?? "") {
                img.load(url: url)
            }}
         
        return img
    }()
    
    lazy var snaptextView: UITextView = {
        let textview = UITextView()
        textview.textAlignment = .left
        if appDelegate.reachability.connection == .unavailable{
            textview.text = coreContent?.data}
        else{
            textview.text = contentdetail?.data
        }
        textview.font =  UIFont(name: "HelveticaNeue-Medium", size: 22)
        return textview
    }()
    
    lazy var snapIdLbl: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "HelveticaNeue-Medium", size: 20)
        if appDelegate.reachability.connection == .unavailable{
            label.text =  "Id: " + (coreContent?.id ?? "")
        }else{
            label.text =  "Id: " + (contentdetail?.id ?? "")}
        return label
    }()
    lazy var snapDateLbl: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "HelveticaNeue-Medium", size: 20)
        if appDelegate.reachability.connection == .unavailable{
            label.text =  "Date: " + (coreContent?.date ?? "")
        }else{
            label.text = "Date: " + (contentdetail?.date ?? "")}
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        view.backgroundColor = .white
        self.view.addSubview(snapView)
        activityIndicator.center =  CGPoint(x: self.snapView.bounds.size.width/2, y: self.snapView.bounds.size.height/2)
        self.snapView.addSubview(activityIndicator)
        setUpNavigation()
        addConstraintForLabel()
        addSuperviewContraint()
        if contentdetail?.type == .image{
            addContraintForImage()
        }else{
            addContraintForTextView()
        }
        self.activityIndicator.stopAnimating()
        
    }
    func setUpNavigation() {
        navigationItem.title = "Content Detail"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
    }
    func addSuperviewContraint(){
        snapView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.view)
            }
    }
    func addConstraintForLabel()
    {
        self.snapView.addSubview(snapIdLbl)
        snapIdLbl.snp.makeConstraints { (make) in
            // make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(400)
            make.left.equalToSuperview().offset(30)
            //  make.right.equalToSuperview().offset(-30)
            make.height.equalTo(30)
        }
        
        self.snapView.addSubview(snapDateLbl)
        snapDateLbl.snp.makeConstraints { (make) in
            // make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(400)
            // make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(30)
        }
    }
    
    func addContraintForImage() {
        snaptextView.removeFromSuperview()
        self.snapView.addSubview(snapImg)
        snapImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(300)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
        }
    }
    
    func addContraintForTextView() {
        snapImg.removeFromSuperview()
        self.snapView.addSubview(snaptextView)
        snaptextView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(300)
        }
    }
}
