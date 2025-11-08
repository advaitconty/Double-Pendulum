//
//  PersistenceManager.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//
//  This code is a boilerplate that has been modified for this use case
//  Original boilerplate available at https://gist.github.com/yjsoon/dd1952a27216721fde5d3e49bb5ff3c9

import Foundation
import Observation

@Observable class PersistenceManager {
    var userData: UserData = UserData() {
        didSet {
            save()
        }
    }
        
    init() {
        load()
    }
    
    private func getArchiveURL() -> URL {
        URL.documentsDirectory.appending(path: "userData.json")
    }
    
    private func save() {
        let archiveURL = getArchiveURL()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let encodeduserData = try? jsonEncoder.encode(userData)
        try? encodeduserData?.write(to: archiveURL, options: .noFileProtection)
    }
    
    private func load() {
        let archiveURL = getArchiveURL()
        let jsonDecoder = JSONDecoder()
                
        if let retrievedUserData = try? Data(contentsOf: archiveURL),
           let userDataDecoded = try? jsonDecoder.decode(UserData.self, from: retrievedUserData) {
            userData = userDataDecoded
        }
    }
}
