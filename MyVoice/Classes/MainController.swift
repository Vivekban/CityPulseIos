//
//  MainController.swift
//  MyVoice
//
//  Created by PB014 on 26/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class MainController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        //ServerRequestInitiater.i.getUserDetail(["userId": "1"])
        
        // ServerRequestInitiater.i.valideUser(["email": "testing1@gmil.com","password":"dummy"])
        //        do{
        //       //let data = try NSJSONSerialization.dataWithJSONObject(json.rawValue, options: NSJSONWritingOptions.PrettyPrinted)
        //           //let string = NSString(data: data, encoding: NSUTF8StringEncoding)
        //
        //            print(json)
        //            print(json.rawString())
        //
        //           // ServerRequestInitiater.i.addUser(["data": json.rawString()!])
        //        }
        //        catch{
        //            print("asdfas")
        //        }
        
        
        // Do any additional setup after loading the view.
        //        let firstStoryboard:UIStoryboard = UIStoryboard(name: "Me", bundle: nil)
        //        let firstViewController:UIViewController = firstStoryboard.instantiateInitialViewController()!
        //
        //        self.viewControllers![1] = firstViewController
        
        
        if  !NSUserDefaults.standardUserDefaults().boolForKey(PermanentDataKey.isLoginDone) {
            
        }
        
        let newUser = PersonBasicData()
        newUser.first_name = " First User"
        newUser.email = "firstUser@gmail.com"
        newUser.initials = "Mr"
        newUser.facebook = "facebook..com/first_user"
        newUser.gender = "m"
        newUser.id = -1
        newUser.dob = TimeDateUtils.getServerStyleDateInString(NSDate())
        newUser.mobile = "1323123123"
        newUser.zip = "12323"
        newUser.password = "asdfasdfasdf"
        
        let jString = MyUtils.appendKayToJSONString(newUser.toJSONString()!)
        print("josn of new user  \(jString)")

     //   ServerRequestInitiater.i.addUser(["json": jString])
        ServerRequestInitiater.i.postMessageToServer(ServerUrls.getIssueByIdUrl, postData: ["issueid": "1"]) { (r) -> Void in
            switch r {
            case .Success(let data):
                
                if let d = data {
                    print(d)
                }
                break
            case .Failure(let error):
                print(error)
                
            }

        }
        
        
        
        var parameter:[String:String] = [String:String]()
        
        parameter["apikey"] = ServerUrls.watsonApiKey
        parameter["text"] = "Here is a piece of C++ code that seems very peculiar. For some strange reason, sorting the data miraculously makes the code almost six times faster.Without std::sort(data, data + arraySize) obama always thought Java was pass-by-reference; however I've seen a couple of blog posts (for example, this blog) that claim it's not. I do not think I understand the distinction they are making.What is the explanation?"
        parameter["maxRetrieve"] = "10"
         parameter["keywordExtractMode"] = "strict"
        parameter["outputMode"] = "json"
        
//        ServerRequestInitiater.i.postMessageToServer(ServerUrls.getEntityUrl, postData: parameter) { (result) -> Void in
//            print(result)
//        }
//
        
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Helvetica", size: CGFloat(15))!], forState:.Normal)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().itemWidth = 100
        
        
        // print(MyUtils.getServerStyleDateInString("Feb 4, 2016"))
        
        //UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        
        //  UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.redColor()], forState:.Selected)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // let tabItemWidth = self.tabBar.itemWidth
        let image = UIImage(named: "tab_selected")
        
        UITabBar.appearance().selectionIndicatorImage = MyUtils.imageResize(image!, sizeChange: CGSize(width: 100, height: 47))
        for item in self.tabBar.items! {
            item.image?.imageWithRenderingMode(.AlwaysOriginal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        // Get the new view controller using segue.destinationViewController.
    //        // Pass the selected object to the new view controller.
    //    }
    
    
}

extension MainController : UITabBarControllerDelegate{
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
    }
}