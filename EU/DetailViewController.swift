//
//  DetailViewController.swift
//  EU
//
//  Created by Reza Koushki on 19/09/2022.
//

import UIKit

class DetailViewController: UITableViewController {

	@IBOutlet weak var saveBarButton: UIBarButtonItem!
	@IBOutlet weak var countryField: UITextField!
	@IBOutlet weak var capitalField: UITextField!
	@IBOutlet weak var usesEuroSwitch: UISwitch!
	
	var nation: Nation!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		if nation == nil {
			nation = Nation(country: "", capital: "", usesEuro: false)
		}
		countryField.text = nation.country
		capitalField.text = nation.capital
		usesEuroSwitch.isOn = nation.usesEuro

    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		nation = Nation(country: countryField.text!, capital: capitalField.text!, usesEuro: usesEuroSwitch.isOn)
	}

	@IBAction func cancelBarButtonPressed(_ sender: UIButton) {
		let isPresentingInAddMode = presentingViewController is UINavigationController
		
		if isPresentingInAddMode {
			dismiss(animated: true, completion: nil)
		} else {
			navigationController?.popViewController(animated: true)
		}
	}
}
