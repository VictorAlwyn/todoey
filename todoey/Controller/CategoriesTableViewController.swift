//
//  CategoriesTableViewController.swift
//  todoey
//
//  Created by alwyn tablatin on 18/04/2018.
//  Copyright © 2018 alwyn tablatin. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesTableViewController: UITableViewController {
    
    
    let realm = try! Realm()
    var Categories: Results<Category>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadcate()
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "add", style: .default) { (action) in
            let newCate = Category()
            newCate.name = textfield.text!


            self.saveCategory(category: newCate)
        }
        
        alert.addAction(action)


        alert.addTextField { (Field) in
            textfield = Field
            textfield.placeholder = "ADD NEW CATEGORY"
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath)
        
        cell.textLabel?.text = Categories?[indexPath.row].name ?? "NO DATA ADDED YET"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToTableView2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = Categories?[indexPath.row]
        }
        
    }
    
    func saveCategory(category : Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadcate(){
        Categories = realm.objects(Category.self)
    }
    
    
}
