//
//  ContentListViewController.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 07/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import UIKit
import Alamofire
class ContentListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchdata()
        // Do any additional setup after loading the view.
    }
    
    func fetchdata() {
        AF.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json").response { response in
            debugPrint(response)
            let jsonData = response.result
//            let user = try! JSONDecoder().decode(ContentListModelElement.self, from: response)
        //    print(user.id)        }
   // }
}
}
}
