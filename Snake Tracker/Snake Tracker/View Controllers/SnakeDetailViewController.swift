//
//  SnakeDetailViewController.swift
//  Snake Tracker
//
//  Created by Thomas Dye on 1/23/21.
//

import UIKit

class SnakeDetailViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
  @IBOutlet weak var doneNavigationButton: UINavigationItem!
  
  var allSnakes: [Snake] = []
  var newSnakeGender: String = ""
  var newSnake: Snake = Snake(name: "", age: "", type: "", gender: "")
  
  override func viewDidLoad() {
        super.viewDidLoad()
    loadSavedSnakes()
    }
  
  // Load saved snakes
  func loadSavedSnakes() {
    
    if let data = UserDefaults.standard.data(forKey: "allSnakesArray") {
      do {
        let arr = try JSONDecoder().decode([Snake].self, from: data)
        allSnakes = arr
        print("all snakes: \(arr)")
      } catch {
        print(error)
      }
    }
  }
  
  func saveNewSnake() {
    
    // Get gender from segmented control
    setGenderToString()
    
    // Unwrap text fields
    guard let newSnakeName = nameTextField.text,
          let newSnakeAge = ageTextField.text,
          let newSnakeType = typeTextField.text else { return }
    
    // Set values
    newSnake.name = newSnakeName
    newSnake.age = newSnakeAge
    newSnake.type = newSnakeType
    newSnake.gender = newSnakeGender
    print(newSnake)
    allSnakes.append(newSnake)
    
    // Store to user defaults
    do {
      let data = try JSONEncoder().encode(allSnakes)
      UserDefaults.standard.set(data, forKey: "allSnakesArray")
    } catch  {
      print(error)
    }
  }
  
  func setGenderToString() {
    
    if genderSegmentedControl.selectedSegmentIndex == 0 {
      newSnakeGender = "male"
    } else {
      newSnakeGender = "female"
    }
  }
  @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
    saveNewSnake()
    print("done button tapped: \(newSnake)")
  }
  
}
