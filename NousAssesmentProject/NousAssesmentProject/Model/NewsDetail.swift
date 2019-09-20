//
//  NewsDetail.swift
//  NousAssesmentProject
//
//  Created by Atalay Asa on 20.09.2019.
//  Copyright © 2019 Atalay Asa. All rights reserved.
//

import Foundation

struct NewsDetail: Decodable  {
    let id: Int64
    let title: String
    let description: String
    let imageUrl: String
}
