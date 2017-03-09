//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    
    @IBOutlet weak var txtInput: UITextField!

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel() {
        
        delegate?.addItemViewControllerDidCancel(controller: self)
        
        
    }
    
    var delegate:AddItemViewControllerDelegate?
    var Item : ChecklistItem?
   
    @IBAction func done() {
        
        if(Item == nil){
            print(txtInput.text)
            delegate?.addItemViewController(controller:self, didFinishAddingItem: ChecklistItem.init(text: txtInput.text!))
            dismiss(animated: true, completion: nil)
            
           
            
          
        }else{
            Item?.text = txtInput.text!
            delegate?.editItemViewController(controller:self, didFinishAddingItem: ChecklistItem.init(text: txtInput.text!))
            dismiss(animated: true, completion: nil)
            //delegate?.documentDirectory()
            
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        txtInput.becomeFirstResponder()
        txtInput.text = Item?.text
    }
    

    @IBAction func txtInputChanged(_ sender: AnyObject) {
        
        let beforeText: NSString = (txtInput.text as NSString?)!
        
        
        if beforeText.length > 0 {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }

    }
    
    
}


protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func editItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    /*func documentDirectory() -> URL
    func dataFileUrl() -> URL
    */
    
}

/*extension AddItemViewController:ChecklistViewControllerDelegate {
    
    func recupInputText(controller: ChecklistViewController){
        
    }
    
}*/
