//
//  PopTableViewController.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit




class PopTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

   
    //  @IBOutlet weak var okButton: UIButton!
    weak var delegate : PopViewControllerDelegate?
    
    var info:PopInfo?
    
    var selectRow : [String]? {
        didSet {
            updatePickerCurrentValue()
        }
    }
    
    convenience init() {
        
        self.init(nibName: "PopTableViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        tableView.backgroundColor = UIColor.whiteColor()
        updatePickerCurrentValue()
        // okButton.hidden = true

    }
    override func viewDidDisappear(animated: Bool) {
        
        self.delegate?.popVCDismissed(nil)
    }
    
    private func updatePickerCurrentValue() {
        if let _currentDate = self.selectRow {
            if (self.tableView != nil) {
                for (i, text) in _currentDate.enumerate(){
                    
                self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: foundOutItem(i, value: text), inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
                }
            }
        }
    }
    
    func foundOutItem(index: Int, value :String) ->Int {
       if value == "" {
            return 0
        }
        else{
            return info?.items![index].indexOf(value) ?? 0
        }
    }

    
//     func onOkButtonClick(sender: UIButton) {
//        self.dismissViewControllerAnimated(true) {
//            var rows = [String]()
//            for (i,item) in (self.info?.items?.enumerate())!  {
//                let j = self.tableView.selectedRowInComponent(i)
//                if (item.count > j){
//                 rows.append(item[j])
//                }
//            }
//            self.delegate?.popVCDismissed(rows.count > 0 ? rows : nil)
//        }
//    }
    
    func onRowSelected( index: Int){
        self.dismissViewControllerAnimated(true) {
            var rows = [String]()
            rows.append((self.info?.items?[0][index])!)
            self.delegate?.popVCDismissed(rows.count > 0 ? rows : nil)
        }

    }
}


    //MARK: UITableViewDataSource

extension PopTableViewController : UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (info?.items![0].count)!

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell
        
        // if cell == nil {
          let  cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        // }
        
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        cell.textLabel?.text =  "  \((info?.items![0][forRowAtIndexPath.row])!)"
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue

    }
   


}

    //MARK: UITableViewDelegate
extension PopTableViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        onRowSelected(indexPath.row)
    }

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//    }
//    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
//
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//    }
//    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 40))
        let field = UILabel(frame: CGRectMake(18, 0, self.view.frame.width - 8, 40))
        field.textAlignment = NSTextAlignment.Center
        field.font = UIFont.boldSystemFontOfSize(18)
        field.text = info?.heading
        
        field.backgroundColor = UIColor.whiteColor()
        view.addSubview(field)
        return view
    }
//
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//    }
    
   
    
//    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
//    
    

}


