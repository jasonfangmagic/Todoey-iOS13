//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jason Fang on 4/9/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView Datasources Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    //MARK: - Data Manipulation Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        tableView.reloadData()
        
        return cell
    }
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {(action) in
            
            
            let newItem = Category(context: self.context)
                
            newItem.title = textField.text!
            
            self.categories.append(newItem)
            
        }
        
        alert.addTextField { (alertTextfied) in
            alertTextfied.placeholder = "Create New Item"
            textField = alertTextfied
        }
        
        alert.addAction(action)
        
        present(alert, animated:  true, completion: nil)
        
    }
    
    func saveItems(){
   
        do{
            try context.save()
            
        } catch{
           print("error")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("error")
        }
    }
    
}

        
    
    //MARK: - TableView Delegate Methods
    
