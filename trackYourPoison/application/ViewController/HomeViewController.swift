//
//  HomeViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController : UIViewController {

    @IBOutlet weak var TimerTable: UITableView!
    @IBOutlet weak var alcoholTimer: UILabel!
    @IBOutlet weak var coffeineTimer: UILabel!
    var timer : Timer?
    var timealc = 10000.0
    var timecof = 20000.0
    @IBOutlet weak var maxSuger: UILabel!
    @IBOutlet weak var maxAlkohol: UILabel!
    @IBOutlet weak var maxCoffiene: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let calc = Calculator()
               timealc = calc.calcAlkohol()
               timecof = calc.calcCoffin()
               maxSuger.text = String("\( calc.maxSugar())%")
               maxAlkohol.text = String("\( calc.maxAlkohol())%")
               maxCoffiene.text = String("\( calc.maxCoffiene())%")
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let start = defaults.integer(forKey: AppDelegate.appStartCount)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if (start == 1) {
            saveData(context : context)
            appDelegate.saveContext()
        }
    }
    
    func saveData(context : NSManagedObjectContext) {
       
        let drinks = SoftDrinkData()
        let sweets = SweetsData()
        let coffee = CoffeeData()
        
        var name = drinks.getName()
        var coffeine = drinks.getCoffeine()
        var sugar = drinks.getSugar()
        var size = drinks.getSize()
        var kcal = drinks.getKcal()
        var image = drinks.getImage()
        
        for (index, _) in name.enumerated(){
            let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.size = size[index]
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "softdrink"
        }
        
        name = sweets.getName()
        coffeine = sweets.getCoffeine()
        sugar = sweets.getSugar()
        var alcohol = sweets.getAlcohol()
        size = sweets.getSize()
        kcal = sweets.getKcal()
        image = sweets.getImage()
    
        for (index, _) in name.enumerated(){
            let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.alcohol = alcohol[index]
            food.size = size[index]
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "sweets"
        }
        
        name = coffee.getName()
        coffeine = coffee.getCoffeine()
        sugar = coffee.getSugar()
        size = coffee.getSize()
        kcal = coffee.getKcal()
        image = coffee.getImage()
        
        for (index, _) in name.enumerated(){
             let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.size = size[index]
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "coffee"
        }
        
        do {
            try context.save()
            print("saved data")
        } catch let error as NSError { print("Could not save. \(error), \(error.userInfo)") }
    
       }
    
    /*timer to string*/
    func timeString(time:TimeInterval) -> String {
       /* let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60*/
        return String("\(time)" )
    }
    @objc func updateTimer(){
        timealc -= 1
        timecof -= 1
        alcoholTimer.text = timeString(time: timealc)
        coffeineTimer.text = timeString(time: timecof)
    }
}
