//
//  DataModel.swift
//  Checklists
//
//  Created by iem on 09/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    static let sharedInstance = DataModel()
    private init() {
        self.list = [Checklist]()
        loadChecklistItems();
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(DataModel.saveChecklistItems), name: .UIApplicationDidEnterBackground, object: nil)
    }
  
    var list: [Checklist]
}


extension DataModel{
    
    
    func documentDirectory() -> URL{
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
    }
    
    func dataFileUrl() -> URL  {
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }
    
    @objc func saveChecklistItems(){
        
        NSKeyedArchiver.archiveRootObject(self.list, toFile: dataFileUrl().path)
        
    }
    
    func loadChecklistItems(){
        if let list = (NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().path) as? [Checklist]){
            self.list = list
        }
    }
    
    

    
}




