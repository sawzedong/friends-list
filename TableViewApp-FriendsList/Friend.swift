//
//  Friend.swift
//  TableViewApp-FriendsList
//
//  Created by Shaw Sheng Saw on 27/6/20.
//  Copyright © 2020 NIL. All rights reserved.
//


import Foundation

class Friend: Codable {
    var Name: String
    var School: String
    var ImageURL: String
    var Age: Int
    var Website: String
    var Attack: Float
    var Defense: Float
    var Stamina: Float
    
    init(Name: String, School: String, ImageURL: String, Age: Int, Website: String) {
        self.Name = Name
        self.School = School
        self.ImageURL = ImageURL
        self.Age = Age
        self.Website = Website
        self.Attack = Float.random(in: 1...20)*10
        self.Attack.round()
        self.Attack /= 10
        self.Defense = Float.random(in: 1...20)*10
        self.Defense.round()
        self.Defense /= 10
        self.Stamina = Float.random(in: 1...20)*10
        self.Stamina.round()
        self.Stamina /= 10
    }
    
    init(Name: String, School: String, ImageURL: String, Age: Int, Website: String, Attack:Float, Defense:Float, Stamina:Float) {
        self.Name = Name
        self.School = School
        self.ImageURL = ImageURL
        self.Age = Age
        self.Website = Website
        self.Attack = Attack
        self.Defense = Defense
        self.Stamina = Stamina
    }
    static func loadSampleData() -> [Friend] {
        let friends = [
            Friend(Name: "MacBook", School: "Apple", ImageURL: "Macbook-img", Age: 4, Website: "https://www.apple.com/mac/"),
            Friend(Name: "Ze Dong", School: "DHS", ImageURL: "ZeDong-img", Age: 13, Website: ""),
            Friend(Name: "Swift", School: "Hello World", ImageURL: "Swift-img", Age: 6, Website: "https://www.apple.com/swift/"),
            Friend(Name: "HTML, CSS, JS", School: "Websites", ImageURL: "HTML-CSS-JS-img", Age: 10, Website: "https://html-css-js.com/"),
            Friend(Name: "Sloth", School: "Cute Animals", ImageURL: "sloth-img", Age: 10, Website: "https://www.worldwildlife.org/species/sloth"),
        ]
        return friends
    }
    
    static func getArchiveURL() -> URL {
        let plistName = "friends"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(friends: [Friend]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedFriends = try? propertyListEncoder.encode(friends)
        try? encodedFriends?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Friend]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedFriendsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedFriends = try? propertyListDecoder.decode(Array<Friend>.self, from: retrievedFriendsData) else { return nil }
        return decodedFriends
    }
    
}
