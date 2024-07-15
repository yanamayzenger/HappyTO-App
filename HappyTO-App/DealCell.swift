//
//  DealCell.swift
//  HappyTO-App
//
//  Created by Yana Mayzenger on 14/07/2024.
//

import UIKit

class DealCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!

    func configure(with deal: RestaurantDeal) {
        nameLabel.text = deal.name
        addressLabel.text = deal.address
        dealsLabel.text = deal.deals
        daysLabel.text = deal.days
    }
}

