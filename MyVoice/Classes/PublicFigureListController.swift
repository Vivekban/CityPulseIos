//
//  PublicFigureListController.swift
//  MyVoice
//
//  Created by PB014 on 22/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

enum PublicFigureListType:Int{
    case TopFigure = 0, MyFigure
}

class PublicFigureListController: BaseNestedTabViewController {
    
    var listType:PublicFigureListType = .TopFigure
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reuseIdentifier = "BriefCell"
        tableView.registerClass(BriefProfileBarTableCell.self, forCellReuseIdentifier: reuseIdentifier)

        serverDataManager = CurrentSession.i.publicFigureDataManager

        entries = CurrentSession.i.publicFigureDataManager.leadearsLists[listType.rawValue].entries
        
                for _ in 0...3{
                    entries.append(CurrentSession.i.personController.person.profileData)
                }
        
        serverListRequestType = listType.rawValue;
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        entries = CurrentSession.i.publicFigureDataManager.leadearsLists[listType.rawValue].entries
        super.updateListEntries(parameter)
    }
    
    
    override func getParameterForListFetching(type: Int) -> [String : AnyObject] {
        var params = super.getParameterForListFetching(type)
        params["tab"] = listType.rawValue
        params["index"] = listType.rawValue
        return params;
    }
    
    //MARK: UITableViewDataSource
    
    override func showDetailViewController(index: Int) -> UIViewController? {
        let controller = SecondPersonProfileViewController()
        
         MyUtils.presentViewControllerOnRoot(self, newController: controller)
        return controller
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if let c = cell as? BriefProfileBarTableCell {
            c.briefView.initialCollectionViews(BriefProfilePersonType.Leadear, dataType: BriefProfileType.TableRow, data: entries[forRowAtIndexPath.row] as! ProfileData)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}

