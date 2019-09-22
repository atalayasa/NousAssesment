//
//  DetailCell.swift
//  NousAssesmentProject
//
//  Created by Atalay Asa on 20.09.2019.
//  Copyright © 2019 Atalay Asa. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    static let reuseId: String = "detailCell"
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
