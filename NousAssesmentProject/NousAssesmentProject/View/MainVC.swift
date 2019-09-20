//
//  ViewController.swift
//  NousAssesmentProject
//
//  Created by Atalay Asa on 20.09.2019.
//  Copyright © 2019 Atalay Asa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MainVC: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: DetailCell.reuseId)
        return tableView
    }()
    let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        viewModel
            .news
            .bind(to: tableView.rx.items(cellIdentifier: DetailCell.reuseId)) { row, model, cell in
                if let cell = cell as? DetailCell {
                    cell.titleLbl.text = "\(model.title)"
                    cell.descLbl?.text = "\(model.description)"
                    let url = URL(string: model.imageUrl)
                    cell.detailImage.kf.indicatorType = .activity
                    cell.detailImage.kf.setImage(with: url)
                }
        }.disposed(by: viewModel.disposeBag)
        viewModel.fetchDate()
    }


}

private extension MainVC {
    enum Constant {
        static let constraintConstant: CGFloat = 10
    }
    private func initView() {
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tableView.topAnchor, constant: Constant.constraintConstant),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constant.constraintConstant),
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
            ])
    }

    private func initVM() {
        
    }
}

