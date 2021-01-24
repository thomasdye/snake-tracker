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
  
  var selectedSnake: Snake = Snake(name: "", age: "", type: "", gender: "", foodType: "", foodSize: "")
    override func viewDidLoad() {
        super.viewDidLoad()
      setSnakeDetails()

        // Do any additional setup after loading the view.
    }
  
  func setSnakeDetails() {
    nameTextField.text = selectedSnake.name
    ageTextField.text = selectedSnake.age
    typeTextField.text = selectedSnake.type
    
    if selectedSnake.gender == "male" {
      genderSegmentedControl.selectedSegmentIndex = 0
    } else {
      genderSegmentedControl.selectedSegmentIndex = 1
    }
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
