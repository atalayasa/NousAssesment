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
import MessageUI

class MainVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: DetailCell.reuseId)
        return tableView
    }()
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
    }
}

private extension MainVC {
    enum Constant {
        static let constraintConstant: CGFloat = 10
    }
    func initView() {
        title = "News"
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tableView.topAnchor, constant: Constant.constraintConstant),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constant.constraintConstant),
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
            ])
        initNavBar()
    }

    func initNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
    }

    func initVM() {
        viewModel
            .filteredItems
            .bind(to: tableView.rx.items(cellIdentifier: DetailCell.reuseId)) { row, model, cell in
                if let cell = cell as? DetailCell {
                    cell.titleLbl.text = "\(model.title)"
                    cell.descLbl?.text = "\(model.description)"
                    let url = URL(string: model.imageUrl)
                    cell.detailImage.kf.indicatorType = .activity
                    cell.detailImage.kf.setImage(with: url)
                }
            }.disposed(by: viewModel.disposeBag)

        tableView
            .rx
            .modelSelected(NewsDetail.self)
            .subscribe(onNext: { (item) in
                self.sendEmail(with: item)
            })
            .disposed(by: viewModel.disposeBag)
        let searchBar = searchController.searchBar
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debug()
            .bind(to: viewModel.searchValue)
            .disposed(by: viewModel.disposeBag)
        viewModel.fetchDate()
    }
    func sendEmail(with detail: NewsDetail) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["atalayasa94@gmail.com"])
            mail.setMessageBody("<p>\(detail.description)</p>", isHTML: true)
            mail.setSubject(detail.title)
            present(mail, animated: true)
        } else {
            print("It seems you are trying to send email on simulator please try it on real device.")
        }
    }
}

extension MainVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Cancelled Mail")
        case .sent:
            print("Sent Mail")
        case .saved:
            print("Mail Sent")
        case .failed:
            print("Failed while sending mail")
        @unknown default:
            print("Unknown error happened")
        }
        controller.dismiss(animated: true)
    }
}
