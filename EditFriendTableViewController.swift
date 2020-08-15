//
//  EditFriendTableViewController.swift
//  TableViewApp-FriendsList
//
//  Created by Shaw Sheng Saw on 25/7/20.
//  Copyright © 2020 NIL. All rights reserved.
//

import UIKit

class EditFriendTableViewController: UITableViewController {
    
    var friend: Friend!
    var newFriend: Bool!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var attackUISlider: UISlider!
    @IBOutlet weak var defenseUISlider: UISlider!
    @IBOutlet weak var staminaUISlider: UISlider!
    @IBOutlet weak var attackTextField: UITextField!
    @IBOutlet weak var defenseTextField: UITextField!
    @IBOutlet weak var staminaTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if nameTextField.text != nil && nameTextField.text != "" && schoolTextField.text != nil && schoolTextField.text != "" && ageTextField.text != nil && ageTextField.text != ""{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        if friend != nil {
            
            self.title = "Edit Mode"
            
            nameTextField.text = friend.Name
            schoolTextField.text = friend.School
            ageTextField.text = "\(friend.Age)"
            attackUISlider.value = friend.Attack
            defenseUISlider.value = friend.Defense
            staminaUISlider.value = friend.Stamina
            attackTextField.text = "\(friend.Attack)"
            defenseTextField.text = "\(friend.Defense)"
            staminaTextField.text = "\(friend.Stamina)"
        } else {
            self.title = "Add Friend"
        }
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        var currentValue = sender.value
        currentValue *= 10
        currentValue = round(currentValue)
        currentValue /= 10
        
        switch sender {
        case attackUISlider:
            attackTextField.text = "\(currentValue)"
        case defenseUISlider:
            defenseTextField.text = "\(currentValue)"
        case staminaUISlider:
            staminaTextField.text = "\(currentValue)"
        default:
            break
            
        }
    }
    
    @IBAction func statsValueChanged(_ sender: UITextField) {
        
        var currentValue = Float(sender.text ?? "") ?? 10.0
        currentValue = round(currentValue*10)/10
        
        if(currentValue > 20.0) {
            currentValue = 20.0
        }
        
        switch sender {
        case attackTextField:
            attackUISlider.value = currentValue
            attackTextField.text = "\(currentValue)"
        case defenseTextField:
            defenseUISlider.value = currentValue
            defenseTextField.text = "\(currentValue)"
        case staminaTextField:
            staminaUISlider.value = currentValue
            staminaTextField.text = "\(currentValue)"
        default:
            print("\(sender) did not trigger actions.")
            
        }
        
        
    }
    @IBAction func ageValueChanged(_ sender: Any) {
        let friendAge = Int(ageTextField.text ?? "") ?? -1
        if friendAge >= 0 {
            ageTextField.text = "\(friendAge)"
        } else{
            ageTextField.text = ""
        }
        
    }
    
    @IBAction func inputValueChanged(_ sender: UITextField) {
        if nameTextField.text != nil && nameTextField.text != "" && schoolTextField.text != nil && schoolTextField.text != "" && ageTextField.text != nil && ageTextField.text != ""{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSave" {
            let friendName = nameTextField.text ?? ""
            let friendSchool = schoolTextField.text ?? ""
            let friendAge = Int(ageTextField.text ?? "") ?? 10
            let imageFileName = "sloth-img"
            let friendAttack = attackUISlider.value
            let friendDefense = defenseUISlider.value
            let friendStamina = staminaUISlider.value
            if friend == nil {
                newFriend = true
                friend = Friend(Name: friendName, School: friendSchool, ImageURL: imageFileName, Age: friendAge, Website: "www.apple.com", Attack:friendAttack, Defense:friendDefense, Stamina:friendStamina)
            } else {
                newFriend = false
                friend.Name = friendName
                friend.School = friendSchool
                friend.Age = friendAge
                friend.Attack = friendAttack
                friend.Defense = friendDefense
                friend.Stamina = friendStamina
            }
        }
    }
    
}
