//
//  ViewController.swift
//  EU
//
//  Created by Reza Koushki on 18/09/2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var euMembers = ["Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "United Kingdom"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			let destination = segue.destination as! DetailViewController
			let selectedIndexPath = tableView.indexPathForSelectedRow!
			destination.countryName = euMembers[selectedIndexPath.row]
		} else {
			if let selectedIndexPath = tableView.indexPathForSelectedRow {
				tableView.deselectRow(at: selectedIndexPath, animated: false)
			}
		}
	}
	
	@IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
		let source = segue.source as! DetailViewController
		if let selectedIndexPath = tableView.indexPathForSelectedRow {
			euMembers[selectedIndexPath.row] = source.countryName
			tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
		} else {
			let newIndexPath = IndexPath(row: euMembers.count, section: 0)
			euMembers.append(source.countryName)
			tableView.insertRows(at: [newIndexPath], with: .bottom)
			tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
		}
	}
	


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("😎 numberOfRowsInSection called. returning \(euMembers.count)")
		return euMembers.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = euMembers[indexPath.row]
		print("🚣‍♀️ CellForRowAt called for indexPath.row =  \(indexPath.row), which is the cell containing \(euMembers[indexPath.row])")
		return cell
	}
	
	
}

