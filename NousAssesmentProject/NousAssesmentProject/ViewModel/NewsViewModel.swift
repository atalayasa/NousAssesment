//
//  NewsViewModel.swift
//  NousAssesmentProject
//
//  Created by Atalay Asa on 20.09.2019.
//  Copyright © 2019 Atalay Asa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NewsViewModel {
    let newsUrl: String = "https://cloud.nousdigital.net/s/sBDBJqFnfeBPrQR/download"
    let disposeBag = DisposeBag()
    let news: BehaviorRelay<[NewsDetail]> = BehaviorRelay(value: [])

    func fetchDate() {
        if let url = URL(string: newsUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let places = try JSONDecoder().decode(News.self, from: data)
                        self.news.accept(places.items)
                    } catch let error {
                        print(error)
                    }
                }
                }.resume()
        }
    }
}
