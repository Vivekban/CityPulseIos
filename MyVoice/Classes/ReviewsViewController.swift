//
//  ReviewsTableViewController.swift
//  MyVoice
//
//  Created by PB014 on 25/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


enum ReviewsViewControllerTabType : Int{
    case SevenDays = 0, ThrityDays, NintyDays, AllTime
}

class ReviewsViewController: BaseProfileNestedViewController {
    
    var isAnalyticsView = false
    
    var tabType = ReviewsViewControllerTabType.SevenDays
    
    static func dayInReviewControllerTabType(tabType: ReviewsViewControllerTabType ) -> Int{
        switch (tabType) {
        case .AllTime:
            return Int.max
        case .NintyDays:
            return 90
        case .ThrityDays:
            return 30
        case .SevenDays:
            return 7
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        if !isAnalyticsView {
            serverListRequestType = PersonInfoRequestType.Reviews.rawValue
        }
        
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        expandedRows.insert(0)
        // detailControllerIdentifier = "MyViewDetailController"
        reuseIdentifier = "reviewCell"
        
        
        if !isAnalyticsView {
            //let data = CurrentSession.i.personController.person.reviewsListManager.entries
            //entries = data
        }
        
        self.tablView = tableView
        
        
        //        let r = ReviewData()
        //        r.reviewerName = "vivek"
        //        r.title = "Fisrt review"
        //        r.description = "This is desc"
        //        entries.append(r)
        //
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        updateEntries(CurrentSession.i.personController.person.reviewsListManager.entries)
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func updateEntries(entries:[BaseData]){
        self.entries.removeAll()
        processEntriesAccordingToTab(entries)
        updateEntries()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)

    }
    
    func processEntriesAccordingToTab(entries:[BaseData]){
        if !isAnalyticsView {
            let time = ReviewsViewController.dayInReviewControllerTabType(tabType)
            let curDate = NSDate()
            for i in entries {
                if let j = i as? TitleDesDateData {
                    
                    print("days \(curDate.numberOfDaysUntilDateTime(j.getNSDate()))")
                    
                    if j.getNSDate().numberOfDaysUntilDateTime(curDate) <= time {
                        self.entries.append(i)
                    }
//                    else{
//                        return
//                    }
                }
            }
        }
        else{
           self.entries.appendContentsOf(entries)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getDataForNewItem() ->BaseData {
        return ReviewData()
    }
    
    
    override func configureTableCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        if let d = entries[indexPath.row] as? ReviewData {
            if let c = cell as? ReviewCell {
                c.delegate = self
                c.updateViewsWithData(d)
            }
        }
    }
    
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
    
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
    
}


extension ReviewsViewController : ReviewCellDelegate {
    func onReportButtonClick(cell: ReviewCell) {
        let index = tableView.indexPathForCell(cell)
        //TODO: take report action
    }
}
