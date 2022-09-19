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
	override func viewDidLoad() {
        super.viewDidLoad()

    }
	@IBAction func cancelBarButtonPressed(_ sender: UIButton) {
		let isPresentingInAddMode = presentingViewController is UINavigationController
		
		if isPresentingInAddMode {
			dismiss(animated: true, completion: nil)
		} else {
			navigationController?.popViewController(animated: true)
		}
	}
	
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return 1
//    }
}
