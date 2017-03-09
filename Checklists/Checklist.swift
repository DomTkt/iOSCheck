//
//  Checklist.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class Checklist: NSObject,NSCoding {
    
    var text: String
    var item: [ChecklistItem]
    
    var uncheckedItemsCount: Int {
        get{
            return item.filter { (selectedItem : ChecklistItem) -> Bool in
                return !selectedItem.checked
                }.count
        }
    }
    
 
    init(txt:String) {
        self.text = txt
        item = [ChecklistItem]()
    }
    
    init(txt:String, item:[ChecklistItem]) {
        self.text = txt
        self.item = item
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let text = decoder.decodeObject(forKey: "text") as? String,
            let item = decoder.decodeObject(forKey: "checklist") as? [ChecklistItem]
            else { return nil }
        
        self.init(
            txt: text,
            item: item
        )
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.item, forKey: "checklist")
    }

    
   

}


