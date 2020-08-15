//
//  FriendsTableViewController.swift
//  TableViewApp-FriendsList
//
//  Created by Shaw Sheng Saw on 27/6/20.
//  Copyright © 2020 NIL. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    var friends: [Friend] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if let loadedFriends = Friend.loadFromFile() {
            print("Found file! Loading friends!")
            friends = loadedFriends
        } else {
            print("No friends 😢 Making some up")
            friends = Friend.loadSampleData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        
        if let cell = cell as? FriendTableViewCell {
            let currentFriend = friends[indexPath.row]
            cell.profileImageView.image = UIImage(named: currentFriend.ImageURL)
            cell.nameLabel.text = currentFriend.Name
            cell.schoolLabel.text = currentFriend.School
            cell.ageLabel.text = String(currentFriend.Age)
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Friend.saveToFile(friends: friends)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let friend = friends.remove(at: fromIndexPath.row)
        friends.insert(friend, at: to.row)
        tableView.reloadData()
        Friend.saveToFile(friends: friends)
     }
     
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriendDetail",
            let destVC = segue.destination as? DetailsViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destVC.friend = friends[indexPath.row]
        }
        
        
    }
    
    @IBAction func backToFriendsTable(with segue: UIStoryboardSegue) {
        if segue.identifier == "unwindSave", let source = segue.source as? EditFriendTableViewController {
            if source.newFriend {
                friends.append(source.friend)
                Friend.saveToFile(friends: friends)
            }
                tableView.reloadData()
            
            }
        }
        
    }

