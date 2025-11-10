//
//  PersistenceManager.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//
//  This code is a boilerplate that has been modified for this use case
//  Original boilerplate available at https://gist.github.com/yjsoon/dd1952a27216721fde5d3e49bb5ff3c9

import Foundation
import SwiftUI

class PersistenceManager: ObservableObject {
    @Published var userData: UserData = UserData() {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "userData.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodeduserData = try? propertyListEncoder.encode(userData)
        try? encodeduserData?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalUserData: UserData!
        
        if let retrievedUserData = try? Data(contentsOf: archiveURL),
            let decodedUserData = try? propertyListDecoder.decode(UserData.self, from: retrievedUserData) {
            finalUserData = decodedUserData
        } else {
            finalUserData = UserData()
        }
        
        userData = finalUserData
    }
}
