//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by 黄逸文 on 2018/7/25.
//  Copyright © 2018 charlie. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    var meals=[Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()
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
}
