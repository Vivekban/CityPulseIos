//
//  PublicFigureListController.swift
//  MyVoice
//
//  Created by PB014 on 22/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

enum PublicFigureListType:Int{
    case TopFigure = 1, MyFigure
}

class PublicFigureListController: BaseNestedTabViewController {

    var listType:PublicFigureListType = .TopFigure
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reuseIdentifier = "BriefCell"
        tableView.registerClass(BriefProfileBarTableCell.self, forCellReuseIdentifier: reuseIdentifier)
        for _ in 0...5{
            entries.append(ProfileData())
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDataSource
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
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

