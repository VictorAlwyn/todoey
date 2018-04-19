//
//  ViewController.swift
//  todoey
//
//  Created by alwyn tablatin on 13/04/2018.
//  Copyright © 2018 alwyn tablatin. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var itemArray: Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
            loadData()
        }
    }
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    //let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(dataFilePath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray?[indexPath.row].title ?? "No data yet"
        
        let itemStatus = itemArray?[indexPath.row]
        
        cell.accessoryType = (itemStatus?.done)! ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray?[indexPath.row])
        
        if let item = itemArray?[indexPath.row]{
            do{
                try realm.write {
                   // realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                print("error updating data \(error)")
            }
        }
        
        tableView.reloadData()
        
        //itemArray[indexPath.row].setValue("true", forKey: "done")
        
        //itemArray[indexPath.row].done != itemArray[indexPath.row].done
        
//        context?.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//
//        saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            
            if let currentCC = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textfield.text!
                        currentCC.items.append(newItem)
                    }
                }catch{
                    print("error saving new Item \(error)")
                }
            }
            
            self.tableView.reloadData()
            
//            let newItem = Item(context: self.context!)
//            newItem.title = textfield.text!
//            newItem.done = false
//            newItem.parentCategories = self.selectedCategory
//
//
//            self.itemArray.append(newItem)
//
//            
//            self.saveItem()
        }
        alert.addTextField { (Textfield) in
            Textfield.placeholder = "Create new item"
            textfield = Textfield
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
//    func saveItem(){
//        do{
//            try context?.save()
//        }catch{
//            print("error saving contect \(error)")
//        }
//
//        tableView.reloadData()
//    }
    
    func loadData(){
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let categoryPredicate = NSPredicate(format: "parentCategories.name MATCHES %@", selectedCategory!.name!)
////
////        request.predicate = predicate
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate!])
//        }else{
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = (try context?.fetch(request))!
//        } catch {
//            print("error fetching data \(error)")
//        }

//        tableView.reloadData()
    }
}

//extension ViewController: UISearchBarDelegate{
////    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        let request : NSFetchRequest<Item> = Item.fetchRequest()
////
////        let predicate = NSPredicate(format: "title CONTAINS[cd] %@",searchBar.text!)
////
////        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
////
////        loadData(with: request,predicate: predicate)
////    }
////    
////    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////        loadData()
////    }
////
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        if searchText.count == 0 {
////            loadData()
////        }
////    }
//}



