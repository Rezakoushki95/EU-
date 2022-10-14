//
//  ListTableViewCell.swift
//  EU
//
//  Created by Reza Koushki on 10/10/2022.
//

import UIKit

protocol listTableViewCellDelegate: AnyObject {
	func euroButtonToggled(sender: ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {
	
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var euroButton: UIButton!
	@IBOutlet weak var capitalLabel: UILabel!
	
	weak var delegate: listTableViewCellDelegate?
	
	var nation: Nation! {
		didSet {
			countryLabel.text = nation.country
			capitalLabel.text = "Capital: \(nation.capital)"
			euroButton.isSelected = nation.usesEuro
		}
	}
	
	@IBAction func euroTapped(_ sender: UIButton) {
		delegate?.euroButtonToggled(sender: self)
		
	}
	
}
