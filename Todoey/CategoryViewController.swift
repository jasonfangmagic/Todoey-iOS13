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
        loadCategories()
    }
    
    //MARK: - TableView Datasources Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
   
    func saveCategories() {
        do{
            try context.save()
            
        } catch{
           print("error")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("error")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {(action) in
            
            
            let newCategory = Category(context: self.context)
                
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addTextField { (alertTextfied) in
            alertTextfied.placeholder = "Create New Item"
            textField = alertTextfied
        }
        
        alert.addAction(action)
        
        present(alert, animated:  true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    
override func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath){
    performSegue(withIdentifier: "goToItems", sender: self)
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinatinoVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinatinoVC.selectedCategories = categories[indexPath.row]
        }
        
    }
    
}

        
    



