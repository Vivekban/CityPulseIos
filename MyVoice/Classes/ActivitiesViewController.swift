//
//  ActivitiesViewController.swift
//  MyVoice
//
//  Created by PB014 on 10/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class ActivitiesViewController: BaseNestedTabViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        columns = 2
        super.viewDidLoad()
        
        collecView = collectionView
        let cellNames = ["creditCell","profileCell","donationCell","pageViewCell","badgeCell"];
        
        for i in 0...4 {
            let d = TitleDescriptionData()
            d.title = cellNames[i]
            entries.append(d)
        }

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onCompleteProfileButtonClick(sender: AnyObject) {
        
        if let c = MainController.getCurrentTabController(self) as? ProfileViewController{
            c.moveToProfileTab()
        }
    
    }
    
    
    override func showDetailViewController(index: Int) -> UIViewController? {
        
        var controllerName = ""
        var title = ""
        
        switch (index) {
        case 0:
            controllerName = "CreditsController"
            title = MyStrings.credits
            break;
        case 1:
            return nil
        case 2:
            controllerName = "DonationController"
            title = CurrentSession.i.personUI?.donationType.toString() ?? "Donations"
            break
        case 3:
            controllerName =  "PageViewsController"
            title = MyStrings.pageViews
            break
        case 4:
            controllerName = "BadgeController"
            title = MyStrings.badges
        default:
            assertionFailure("detail view in not implemented")
            break;
        }
      guard let controller =  MyUtils.getViewControllerFromStoryBoard("Activity", controllerName: controllerName)
        else{
            return nil
        }
       
        controller.title = title
        
        if let tabController = self.view.window?.rootViewController as? UITabBarController {
            if let profile = tabController.selectedViewController as? ProfileViewController {
                profile.addAdditionView(controller)
            }
        }
        
        
        //  MyUtils.presentViewController(self, newController: controller)
       
        return controller

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if let d = entries[indexPath.row] as?  TitleDescriptionData{
             reuseIdentifier = d.title
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if let c = cell as? BaseActivityCell {
            c.delegate = self
        }
        
        // indexPath.section
        // indexPath.row
        // Configure the cell
        
        return cell
    }


}

extension ActivitiesViewController : ActivityCellDelegate {
    func onMoreButtonClick(sender: BaseActivityCell) {
        showDetailViewController((collectionView.indexPathForCell(sender)?.row) ?? 0)
    }
}
