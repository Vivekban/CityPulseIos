//
//  AppDelegate.swift
//  MyVoice
//
//  Created by PB014 on 21/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import XCGLogger
//import Fabric
//import Crashlytics


let log = XCGLogger.defaultInstance()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        CurrentSession.i.initVariable()

        self.window?.backgroundColor = UIColor.whiteColor()
        
        // Override point for customization after application launch.
        MyUtils.setStatusBarBackgroundColor(Constants.primaryColor)
        
        let cacheDirectory: NSURL = {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
            return urls[urls.endIndex - 1]
        }()
        let logPath: NSURL = cacheDirectory.URLByAppendingPathComponent("app.log")
        log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath, fileLogLevel: .Debug)
        
        log.xcodeColorsEnabled = true
        
        // Fabric.with([Crashlytics.self])
        //Fabric.sharedSDK().debug = true
      log.debug("Start...................")

        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:UIFont.boldSystemFontOfSize(20),NSForegroundColorAttributeName:UIColor.darkGrayColor()]
        
        
        let view = UIView()
        view.backgroundColor = Constants.accentColor
        
        //  UITableViewCell.appearance().selectedBackgroundView = view
        
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return .All;
        
    }
    
}

