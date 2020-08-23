//
//  ContentListModel.swift
//  CodeChallenge
//
//  Created by Priyanka Morey on 07/08/20.
//  Copyright © 2020 Priyanka Morey. All rights reserved.
//

import Foundation

// MARK: - ContentListModelElement
struct ContentListModelElement: Codable {
    let id: String
    let type: TypeEnum
    let date: String?
    let data: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
    case other = "other"
    case text = "text"
}
typealias ContentListModel = [ContentListModelElement]
