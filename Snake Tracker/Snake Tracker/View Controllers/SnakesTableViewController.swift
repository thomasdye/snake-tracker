//
//  SnakesTableViewController.swift
//  Snake Tracker
//
//  Created by Thomas Dye on 1/23/21.
//

import UIKit

class SnakesTableViewController: UITableViewController {

  var allSnakes: [Snake] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadSavedSnakes()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    loadSavedSnakes()
    tableView.reloadData()
  }

    // MARK: - Table view data source
  
  // Load saved snakes
  func loadSavedSnakes() {
    
    if let data = UserDefaults.standard.data(forKey: "allSnakesArray") {
      do {
        let arrayOfDecodedSnakes = try JSONDecoder().decode([Snake].self, from: data)
        allSnakes = arrayOfDecodedSnakes
        print("all snakes: \(allSnakes)")
      } catch {
        print(error)
      }
    }
  }

    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return allSnakes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "snakeCell", for: indexPath)
      
      let snake = allSnakes[indexPath.row]
      cell.textLabel?.text = snake.name
      cell.detailTextLabel?.text = snake.type
      return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
          loadSavedSnakes()
          allSnakes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
          // Store to user defaults
          do {
            let data = try JSONEncoder().encode(allSnakes)
            UserDefaults.standard.set(data, forKey: "allSnakesArray")
          } catch  {
            print(error)
          }
          
          
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "snakeSegue" {
      
      guard let indexPath = tableView.indexPathForSelectedRow,
            let snakeDetailVC = segue.destination as? SnakeDetailViewController else { return }
      
      let selectedSnake = allSnakes[indexPath.row]
      snakeDetailVC.selectedSnake = selectedSnake
    }
  }

}
