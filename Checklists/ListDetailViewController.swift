//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {
    @IBAction func cancel() {
            
            delegate?.addItemViewControllerDidCancel(controller: self)
            
        
    }
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var txtInput: UITextField!
    
    @IBAction func txtInputChanged(_ sender: AnyObject) {
        
        let beforeText: NSString = (txtInput.text as NSString?)!
        
        
        if beforeText.length > 0 {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }
        
    
        
    }
    
    @IBAction func done() {
        
        if(Item == nil){
            print(txtInput.text)
            delegate?.addItemViewController(controller:self, didFinishAddingItem: Checklist.init(txt: txtInput.text!))
            dismiss(animated: true, completion: nil)
            
            
            
            
        }else{
            Item?.text = txtInput.text!
            delegate?.editItemViewController(controller:self, didFinishAddingItem: Checklist.init(txt: txtInput.text!))
            dismiss(animated: true, completion: nil)
            //delegate?.documentDirectory()
            
        }
        
    }
    
    @IBOutlet weak var cancelBt: UIBarButtonItem!
    @IBOutlet weak var AddBt: UIBarButtonItem!
    var delegate: ListDetailViewControllerDelegate?
    var Item : Checklist?
}



protocol ListDetailViewControllerDelegate : class {
    func addItemViewControllerDidCancel(controller: ListDetailViewController)
    func addItemViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func editItemViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist)
       
    
}


    
    



