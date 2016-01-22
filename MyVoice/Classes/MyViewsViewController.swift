//
//  MyViewsViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class MyViewsViewController: BaseNestedTabViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        expandedRows.insert(0)
        
        editControlllerIdentifier = "EditViewsViewController"
        detailControllerIdentifier = "MyViewDetailController"
        reuseIdentifier = "MyViewsCell"
        
        let data = CurrentSession.i.personController.person.views
        
        for entry in data {
            entries.append(entry)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getDataForNewItem() ->BaseData {
        return MyViewData()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyViewTableCell
        cell.tag = indexPath.row
        cell.touchDelegate = self
        if expandedRows.contains(indexPath.row){
            cell.isExpanded = true
        }
        else{
            cell.isExpanded = false
        }
        
        if let entry = entries[indexPath.row] as? MyViewData{
            cell.heading.text = entry.title
            cell.detailLabel.text = entry.description
            cell.detailLabel.sizeToFit()
            cell.dateField.text = entry.date
        }
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(expandedRows.contains(indexPath.row)){
            return 150
        }
        else{
            return 55;
        }
        
    }
    
    func updateRow(section: Int, row:Int){
        var rows = [NSIndexPath]()
        let row = NSIndexPath(forRow: row, inSection: section)
        rows += [row]
        self.tableView.reloadRowsAtIndexPaths(rows, withRowAnimation: .Automatic)
        print("update rows.........")
    }
    
    
    override func reloadData(index: Int) {
        updateRow(0, row: index)
        
    }
    
    override func onDetailClick(index: Int) {
        super.onDetailClick(index)
        updateRow(0, row: index)
        // updateRow(0, row: cell.tag)
    }
    
}



