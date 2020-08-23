//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 06/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import CoreData
import Reachability
class ViewController: UIViewController, UITableViewDelegate {
    let tableView = UITableView()
    let imgUser = UIImageView()
    let labUserName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()
    var contentViewModel = ContentViewModel()
    var contentManager = ContentDataManager()
    var conteEntity = Array<Content>()
    var contentDetail:  ContentListModelElement?
    var reachability: Reachability!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var contentList: ContentListModel?{
        didSet {
            guard let contentList = contentList else { return }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContent()
    }
    
    override func loadView() {
        super.loadView()
        setupTableView()
        setUpNavigation()
    }
  
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setUpNavigation() {
        navigationItem.title = "Content List"
        //self.navigationController?.navigationItem.i
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
    }
}

//Tableview Datasource and Delegate Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appDelegate.reachability.connection == .unavailable{
            return conteEntity.count
        }else{
            return contentList?.count ?? 0}
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ContentTableViewCell
        if appDelegate.reachability.connection == .unavailable{ cell?.setupUI(model: nil, coreDataModel: conteEntity[indexPath.row])
        }else{
            if let content = contentList?[indexPath.row] {
                cell?.setupUI(model: content, coreDataModel: nil)
            }
            
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentDetailViewController = ContentDetailViewController()
        if appDelegate.reachability.connection == .unavailable{
            contentDetailViewController.coreContent = conteEntity[indexPath.row]
        }else {
            
            if let selectedseContent = contentList?[indexPath.row] {
                contentDetailViewController.contentdetail = selectedseContent
            }
        }
        self.navigationController?.pushViewController(contentDetailViewController, animated: true)
    }
    
 //MARKS:API CAll
    private func getContent() {
        if appDelegate.reachability.connection == .unavailable{
            let coreDataContent = contentManager.fetchAllContentList()
            conteEntity = coreDataContent! ?? []
        }else
        {
            contentViewModel.fetchdata() { (content, error) in
                if let error = error {
                    print("Get weather error: \(error.localizedDescription)")
                    return
                }
                guard let content = content  else { return }
                self.contentList = content
                self.contentManager.deleteAll()
                for content in content {
                    self.contentManager.addItem(id:content.id ,date:content.date ?? "",data:content.data ?? "",type:content.type.rawValue )
                }
                self.tableView.reloadData()
            }
            
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
