//
//  ViewController.swift
//  TableViewApp-FriendsList
//
//  Created by Shaw Sheng Saw on 27/6/20.
//  Copyright © 2020 NIL. All rights reserved.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var attackSlider: UISlider!
    @IBOutlet weak var defenseSlider: UISlider!
    @IBOutlet weak var staminaSlider: UISlider!
    @IBOutlet weak var attackValueLabel: UILabel!
    @IBOutlet weak var defenseValueLabel: UILabel!
    @IBOutlet weak var staminaValueLabel: UILabel!
    
    var friend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = friend.Name
        
        friendImage.image = UIImage(named: friend.ImageURL)
        attackSlider.value = round(friend.Attack*10)/10
        attackValueLabel.text = "\(round(friend.Attack*10)/10)"
        defenseSlider.value = round(friend.Defense*10)/10
        defenseValueLabel.text = "\(round(friend.Defense*10)/10)"
        staminaSlider.value = round(friend.Stamina*10)/10
        staminaValueLabel.text = "\(round(friend.Stamina*10)/10)"
    }
    
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        var currentValue = sender.value
        
        currentValue *= 10
        currentValue = round(currentValue)
        currentValue /= 10
        
        switch sender {
        case attackSlider:
            attackValueLabel.text = "\(currentValue)"
            friend.Attack = currentValue
        case defenseSlider:
            defenseValueLabel.text = "\(currentValue)"
            friend.Defense = currentValue
        case staminaSlider:
            staminaValueLabel.text = "\(currentValue)"
            friend.Stamina = currentValue
        default:
            attackValueLabel.text = "App Crashed: Alert Dev"
        }
        
    }
    @IBAction func websiteButtonClicked(_ sender: Any) {
        let urlString = friend.Website
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            
            present(vc, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editFriend", let navController = segue.destination as? UINavigationController, let destVC = navController.viewControllers.first as? EditFriendTableViewController {
            
            destVC.friend = friend
        }
    }
}

