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
	
	var countryName: String!
	override func viewDidLoad() {
        super.viewDidLoad()
		countryField.text = countryName

    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		countryName = countryField.text
		
		if countryName == nil {
			countryName = ""
		}
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
