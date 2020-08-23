//
//  ContentViewModel.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 07/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import Foundation
import Alamofire
class ContentViewModel {
   
    func fetchdata(completion: @escaping (_ content: ContentListModel?, _ error: Error?) -> Void) {
        AF.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json").response { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                //let news = [value]
                if let value = value{
                    let content = try! JSONDecoder().decode(ContentListModel.self, from: value)
                     return completion(content, nil)
                    //self.tableView.reloadData()
                    // print(contentList[0].id)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
