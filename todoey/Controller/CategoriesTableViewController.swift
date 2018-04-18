//
//  CategoriesTableViewController.swift
//  todoey
//
//  Created by alwyn tablatin on 18/04/2018.
//  Copyright © 2018 alwyn tablatin. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableViewController: UITableViewController {
    
    var Categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadcate()
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Categoru", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            let newCate = Category(context: self.context)
            newCate.name = textfield.text!
            
            self.Categories.append(newCate)
            
            self.saveCategory()
        }
        
        alert.addAction(action)
        
        
        alert.addTextField { (Field) in
            textfield = Field
            textfield.placeholder = "ADD NEW CATEGORY"
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath)
        
        cell.textLabel?.text = Categories[indexPath.row].name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToTableView2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = Categories[indexPath.row]
        }
        
    }
    
    func saveCategory(){
        do {
            try context.save()
        } catch {
            print("error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadcate(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
         try Categories = context.fetch(request)
        }catch{
            print("error fetching data \(error)")
        }
        
        tableView.reloadData()
    }
    
    
}
