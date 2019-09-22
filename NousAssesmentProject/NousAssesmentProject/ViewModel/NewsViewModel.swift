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

final class NewsViewModel {
    let newsUrl: String = "https://cloud.nousdigital.net/s/sBDBJqFnfeBPrQR/download"
    let disposeBag = DisposeBag()
    let news: BehaviorRelay<[NewsDetail]> = BehaviorRelay(value: [])
    var filteredItems: BehaviorRelay<[NewsDetail]> = BehaviorRelay(value: [])
    var searchValue: BehaviorRelay<String> = BehaviorRelay(value: "")
    lazy var searchValueObservable: Observable<String> = self.searchValue.asObservable()
    lazy var itemsObservable: Observable<[NewsDetail]> = self.news.asObservable()
    /// Observable Array while searching
    lazy var filteredItemsObservable: Observable<[NewsDetail]> = self.filteredItems.asObservable()
    
    init() {
        searchValueObservable.subscribe(onNext: { [weak self] (value) in
            guard let `self` = self else { return }
            self.itemsObservable.map({
                $0.filter({
                    if value.isEmpty { return true }
                    return $0.title.lowercased().contains(value.lowercased())
                        || $0.description.lowercased().contains(value.lowercased())
                })
            })
                .bind(to: self.filteredItems)
                .disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func fetchDate() {
        if let url = URL(string: newsUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let `self` = self else { return }
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
