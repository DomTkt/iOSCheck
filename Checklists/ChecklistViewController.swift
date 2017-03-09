//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var list: Checklist!
    
    //var tabChecklistItem = [ChecklistItem]()
    var rowClick = 0
    //let tabChecklistItem
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
            self.title = self.list.text
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //tabChecklistItem = [ChecklistItem(text: "test1"),ChecklistItem(text:"test2",checked:true)]
        
        
        /*for i in 0  ..< 10  {
            tabChecklistItem.append(ChecklistItem(text: "Finir le cours d’iOS"+" "+String(i) ,checked: false))
        }
        tabChecklistItem[5].toogleChecked()
        */
        //loadChecklistItems()
        
        //ChecklistItem(text: "Finir le cours d’iOS"))
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        //loadChecklistItems()
        
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
            targetController.Item = list.item[(indexPath?.row)!]
            targetController.title = "Edition de la sous tâche : \(list.item[(indexPath?.row)!].text) "
            
            
            
            
            
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.item.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{ 
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureTextFor(cell: cell, withItem: list.item[indexPath.row])
        configureCheckmarkFor(cell: cell, withItem: list.item[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowClick = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
        list.item[indexPath.row].toogleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //saveChecklistItems()
        tableView.reloadData()
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
        list.item.append(ChecklistItem(text:"test"))
        let indexPath = IndexPath(row: list.item.count-1 , section: 0)
        listView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        list.item.remove(at: indexPath.row)
        listView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        //saveChecklistItems()
        tableView.reloadData()
        
    }
    
  

}

extension ChecklistViewController: AddItemViewControllerDelegate{
    
    
    func addItemViewControllerDidCancel(controller: AddItemViewController){
        dismiss(animated: true, completion: nil)
        

    }
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem){
        list.item.append(item)
        let indexPath = IndexPath(row: list.item.count-1 , section: 0)
        listView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //saveChecklistItems()
    }
    
    func editItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        listView.reloadData()
        //saveChecklistItems()
    }
    
   /* func documentDirectory() -> URL{
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
    }
    
    func dataFileUrl() -> URL  {
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }
    
    func saveChecklistItems(){

        NSKeyedArchiver.archiveRootObject(self.list.item, toFile: dataFileUrl().path)
    
    }
    
    func loadChecklistItems(){
        if let list = (NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().path) as? [ChecklistItem]){
            self.list.item = list
        }
    }
    */
    
    
    
    
    //func saveChecklistitems()
    

    

}


/*protocol ChecklistViewControllerDelegate : class {

}*/
