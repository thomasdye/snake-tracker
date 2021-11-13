//
//  AddSnakeViewController.swift
//  Snake Tracker
//
//  Created by Thomas Dye on 11/13/21.
//

import Foundation
import UIKit

class AddSnakeViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var morphTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  @IBOutlet weak var lastFeedingDatePicker: UIDatePicker!
  @IBOutlet weak var frozenLiveSegmentedControl: UISegmentedControl!
  @IBOutlet weak var foodSizeSegementedControl: UISegmentedControl!
  @IBOutlet weak var saveSnakeButton: UIButton!
  
  var newSnake: Snake = Snake(name: "", morph: "", age: 0, feedingTimes: [], frozen: false, foodSize: 0)
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadSnakesFromUserDefaults()
  }
  
  func checkUserInput() -> Bool {
    
    if nameTextField.text == "" {
      print("create popup")
      return false
    } else if morphTextField.text == "" {
      print("create popup")
      return false
    } else if ageTextField.text == "" {
      print("create popup")
      return false
    } else {
      return true
    }
  }
  
  func saveUserDefaults() {
    
    let checkUserInput = checkUserInput()
    var frozenBool: Bool = false
    
    if checkUserInput == true {
      
      guard let snakeName = nameTextField.text,
            let snakeMorph = morphTextField.text,
            let snakeAgeString = ageTextField.text
      else {
        return
        
      }
      
      guard let snakeAge = Int(snakeAgeString) else { return }
      
      if frozenLiveSegmentedControl.selectedSegmentIndex == 0 {
        frozenBool = true
      } else {
        frozenBool = false
      }
      
      let foodSize = foodSizeSegementedControl.selectedSegmentIndex + 1
      
      newSnake = Snake(name: snakeName, morph: snakeMorph, age: snakeAge, feedingTimes: [Feed(type: "", date: lastFeedingDatePicker.date)], frozen: frozenBool, foodSize: foodSize)
      allSnakes.append(newSnake)
      do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(allSnakes)
        defaults.set(data, forKey: "allSnakes")
        print("successfully saved snake")
      } catch {
        print("undable to encode snake")
      }
    }
  }
  
  func loadSnakesFromUserDefaults() {
    if let data = defaults.data(forKey: "allSnakes") {
      do {
        let decoder = JSONDecoder()
        allSnakes = try decoder.decode([Snake].self, from: data)
        print("Decoded Snakes Succesfully")
        print(allSnakes[0])
      } catch {
        print("Unable to Decode Snakes")
      }
    }
  }
  
  @IBAction func saveSnakeButtonTapped(_ sender: UIButton) {
    saveUserDefaults()
  }
}

