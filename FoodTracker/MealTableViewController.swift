//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by 黄逸文 on 2018/7/25.
//  Copyright © 2018 charlie. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    var meals=[Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem=editButtonItem
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }else {
            // Load the sample data.
            loadSampleMeals()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier="MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let meal=meals[indexPath.row]
        cell.nameLabel.text=meal.name
        cell.photoImageView.image=meal.photo
        cell.ratingControl.rating=meal.rating
        return cell
    }
    
    override func tableView(_ tableView:UITableView,commit editingStyle:UITableViewCellEditingStyle,forRowAt indexPath:IndexPath){
        if editingStyle == .delete{
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else if editingStyle == .insert{
            //nothing
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? ""){
        case "AddItem":
            os_log("Adding a new servant", log:OSLog.default,type: .debug)
        case "ShowDetail":
            guard let mealTableViewController=segue.destination as? MealViewController else{
              fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
        
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealTableViewController.meal = selectedMeal
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController=sender.source as?
            MealViewController, let meal=sourceViewController.meal{
            if let seletedIndexPath=tableView.indexPathForSelectedRow{
                meals[seletedIndexPath.row]=meal
                tableView.reloadRows(at: [seletedIndexPath], with: .none)
                
            }else{
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveMeals()
        }
    }
    
    private func loadSampleMeals() {
        guard let servant1 = Meal(name: "Archor Ishtar", photo: UIImage(named: "sample1"), rating: 5) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let servant2 = Meal(name: "Saber Bride Nero", photo: UIImage(named: "sample2"), rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let servant3 = Meal(name: "Saber Altria Alter", photo: UIImage(named: "sample3"), rating: 4) else {
            fatalError("Unable to instantiate meal2")
        }
        meals+=[servant1,servant2,servant3]
        
    }
    
    private func saveMeals(){
        let isSuccessfulSave=NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
       
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals()->[Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
}
