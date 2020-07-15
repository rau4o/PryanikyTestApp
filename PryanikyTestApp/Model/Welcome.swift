//
//  Welcome.swift
//  PryanikyTestApp
//
//  Created by rau4o on 7/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

struct Welcome: Decodable {
    let data: [Datum]
    let view: [String]
}

struct Datum: Decodable {
    let name: String
    let data: DataClass
}

struct DataClass: Decodable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?
}

struct Variant: Decodable {
    let id: Int
    let text: String
}

