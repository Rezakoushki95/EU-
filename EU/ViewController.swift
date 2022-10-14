//
//  ViewController.swift
//  EU
//
//  Created by Reza Koushki on 18/09/2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var addBarButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!
	
	var nations: [Nation] = []
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		
		loadData()
	}
	
	func saveData() {
		let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let documentURL = directoryURL.appendingPathComponent("nations").appendingPathExtension("json")
		
		let jsonEncoder = JSONEncoder()
		let data = try? jsonEncoder.encode(nations)
		
		do {
			try data?.write(to: documentURL, options: .noFileProtection)
		} catch {
			print("ERROR Could not save data \(error.localizedDescription)")
		}
	}
	
	func loadData() {
		let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let documentURL = directoryURL.appendingPathComponent("nations").appendingPathExtension("json")
		
		guard let data = try? Data(contentsOf: documentURL) else {return}
		let jsonDecoder = JSONDecoder()
		do {
			nations = try jsonDecoder.decode(Array<Nation>.self, from: data)
			tableView.reloadData()
		} catch {
			print("ERROR Could Not Load Data \(error.localizedDescription)")
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			let destination = segue.destination as! DetailViewController
			let selectedIndexPath = tableView.indexPathForSelectedRow!
			destination.nation = nations[selectedIndexPath.row]
		} else {
			if let selectedIndexPath = tableView.indexPathForSelectedRow {
				tableView.deselectRow(at: selectedIndexPath, animated: false)
			}
		}
	}
	
	@IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
		let source = segue.source as! DetailViewController
		if let selectedIndexPath = tableView.indexPathForSelectedRow {
			nations[selectedIndexPath.row] = source.nation
			tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
		} else {
			let newIndexPath = IndexPath(row: nations.count, section: 0)
			nations.append(source.nation)
			tableView.insertRows(at: [newIndexPath], with: .bottom)
			tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
		}
		saveData()
	}
	
	@IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
		if tableView.isEditing {
			tableView.setEditing(false, animated: true)
			sender.title = "Edit"
			addBarButton.isEnabled = true
		} else {
			tableView.setEditing(true, animated: true)
			sender.title = "Done"
			addBarButton.isEnabled = false
		}
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, listTableViewCellDelegate {
	
	func euroButtonToggled(sender: ListTableViewCell) {
		if let selectedIndexPath = tableView.indexPath(for: sender) {
			nations[selectedIndexPath.row].usesEuro = !nations[selectedIndexPath.row].usesEuro
			tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
			saveData()
		}
			
		
	}
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return nations.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
		cell.delegate = self
		cell.nation = nations[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			nations.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			saveData()
		}
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let itemToEdit = nations[sourceIndexPath.row]
		nations.remove(at: sourceIndexPath.row)
		nations.insert(itemToEdit, at: destinationIndexPath.row)
		saveData()
	}
}

