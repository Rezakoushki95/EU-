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
	
	var countries = ["Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "United Kingdom"]
	
	var captials = ["Vienna", "Brussels", "Sofia", "Zagreb", "Nicosia", "Prague", "Copenhagen", "Tallinn", "Helsinki", "Paris", "Berlin", "Athens", "Budapest", "Dublin", "Rome", "Riga", "Vilnius", "Luxembourg (city)", "Valetta", "Amsterdam", "Warsaw", "Lisbon", "Bucharest", "Bratislava", "Ljubljana", "Madrid", "Stockholm", "London"]
	
	var usesEuro = [true, true, false, false, true, false, false, true, true, true, true, true, false, true, true, true, true, true, true, true, false, true, false, true, true, true, false, false]
	
	
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
			let newIndexPath = IndexPath(row: countries.count, section: 0)
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("😎 numberOfRowsInSection called. returning \(countries.count)")
		return nations.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = nations[indexPath.row].country
		cell.detailTextLabel?.text = "Capital: \(nations[indexPath.row].capital)"
		print("🚣‍♀️ CellForRowAt called for indexPath.row =  \(indexPath.row), which is the cell containing \(nations[indexPath.row].country)")
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

