//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    
    var tabChecklistItem = [ChecklistItem]()
    var rowClick = 0
    //let tabChecklistItem
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //tabChecklistItem = [ChecklistItem(text: "test1"),ChecklistItem(text:"test2",checked:true)]
        
        
        for i in 0  ..< 10  {
            tabChecklistItem.append(ChecklistItem(text: "Finir le cours d’iOS"+" "+String(i) ,checked: false))
        }
        tabChecklistItem[5].toogleChecked()
        
        
        
        //ChecklistItem(text: "Finir le cours d’iOS"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "AddItem"){
            let destinationNav = segue.destination as? UINavigationController
            let targetController = destinationNav?.topViewController as! AddItemViewController
            targetController.delegate = self;
            
        }
        
        else if(segue.identifier == "EditItem"){
            let cell = sender as! UITableViewCell?
            let indexPath = self.tableView.indexPath(for: cell!)
            
            let destinationNav = segue.destination as? UINavigationController
            
            let targetController = destinationNav?.topViewController as! AddItemViewController
            targetController.delegate = self;
            targetController.Item = tabChecklistItem[(indexPath?.row)!]
            targetController.title = "Edit Text"
            
            
            
            
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tabChecklistItem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{ 
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureTextFor(cell: cell, withItem: tabChecklistItem[indexPath.row])
        configureCheckmarkFor(cell: cell, withItem: tabChecklistItem[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowClick = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
        tabChecklistItem[indexPath.row].toogleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    func configureCheckmarkFor(cell: UITableViewCell, withItem item: ChecklistItem)
    {
        if(item.checked){
            //cell.accessoryType = UITableViewCellAccessoryType.checkmark
            let label = cell.viewWithTag(1) as! UILabel
            
            label.isHidden = false;
        }else{
           // cell.accessoryType = UITableViewCellAccessoryType.none
            let label = cell.viewWithTag(1) as! UILabel
            label.isHidden = true;
        }
    }
    
    func configureTextFor(cell: UITableViewCell, withItem item: ChecklistItem){
        
        let label = cell.viewWithTag(2) as! UILabel
        label.text = item.text
    }
    
    
    
    
    @IBOutlet var listView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    @IBAction func addDummyTodo(_ sender: AnyObject) {
        tabChecklistItem.append(ChecklistItem(text:"test"))
        let indexPath = IndexPath(row: tabChecklistItem.count-1 , section: 0)
        listView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        tabChecklistItem.remove(at: indexPath.row)
        listView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
    }
    
  

}

extension ChecklistViewController: AddItemViewControllerDelegate{
    
    
    func addItemViewControllerDidCancel(controller: AddItemViewController){
        dismiss(animated: true, completion: nil)

    }
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem){
        tabChecklistItem.append(item)
        let indexPath = IndexPath(row: tabChecklistItem.count-1 , section: 0)
        listView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    func editItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        listView.reloadData()
    }
    
    func documentDirectory() -> URL{
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentDirectory)
        return documentDirectory
        
    }
    
    func dataFileUrl() -> URL  {
        return documentDirectory().appendingPathComponent("ChecklistItem.plist")
    }
    
    //func saveChecklistitems()
    

    

}


/*protocol ChecklistViewControllerDelegate : class {

}*/
