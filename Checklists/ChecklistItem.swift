//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation


class ChecklistItem : NSObject, NSCoding {

    var text: String
    var checked: Bool
    
    init(text: String){
        self.text = text
        self.checked = false
    }
    
    init(text:String, checked:Bool) {
        self.text = text
        self.checked = checked
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let text = decoder.decodeObject(forKey: "text") as? String
            else { return nil }
        
        self.init(
            text: text,
            checked: decoder.decodeBool(forKey: "checked")
        )
    }
     
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.checked, forKey: "checked")
    }
    
    func toogleChecked(){
        
        if(self.checked){
            checked.self = false
        }else{
            checked.self = true
        }
      
    }
    
   

}
