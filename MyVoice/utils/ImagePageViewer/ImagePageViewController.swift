//
//  ImagePageViewController.swift
//  MyVoice
//
//  Created by PB014 on 19/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol ImagePageViewControllerDelegate{
    func finalChanges(urls:[String], images : [Int:UIImage])
}

class ImagePageViewController: UIViewController {
    //data
    var images:[Int:UIImage]?
    var imagesUrls:[String]!
    var initialPosition:Int = 0
    var delegate:ImagePageViewControllerDelegate?
    
    var pageViewController:UIPageViewController!
    
    static func newInstance(urls:[String], images : [Int:UIImage] , initialPosition: Int) -> ImagePageViewController {
        
        let controller = ImagePageViewController()
        controller.images = images
        controller.imagesUrls = urls
        controller.initialPosition = initialPosition
        return controller
        //        if let viewController = viewController {
        //            self.presentViewController(viewController, animated: true, completion: nil)
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let storyboard = UIStoryboard(name: "FullImageView", bundle: NSBundle.mainBundle())
        pageViewController = storyboard.instantiateInitialViewController() as! UIPageViewController
        pageViewController.dataSource = self
        pageViewController.delegate = self
        setViewControllerForPageView(initialPosition)
        pageViewController.view.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
        createNavigationBar()

        // self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func createNavigationBar(){
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        bar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        MyUtils.makeNavigationBarTransparent(bar)
        
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "onBackButtonPress")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "onDeleteButtonPress")
        bar.items = [navigationItem]
        self.view.addSubview(bar)
        
    }
    
    func setViewControllerForPageView(index:Int){
        if let firstController = getItemController(index) {
            pageViewController.setViewControllers([firstController], direction: .Forward, animated: false, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getItemController(itemIndex: Int) -> PagerContentViewController? {
        
        let pageItemController = pageViewController.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PagerContentViewController
        pageItemController.index = itemIndex
        if ( !imagesUrls[itemIndex].isEmpty) {
            pageItemController.imageName = imagesUrls[itemIndex]
        }
        else if let img = images![itemIndex]{
            pageItemController.image = img
        }
        else{
            assertionFailure()
        }
        return pageItemController
        
    }
    
    func onBackButtonPress() {
        delegate?.finalChanges(self.imagesUrls, images: self.images!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onDeleteButtonPress() {
        imagesUrls.removeAtIndex(initialPosition)
        removeItemFromDictionary(initialPosition)
        
        if imagesUrls.count > 0 {
            let nextControllerIndex = initialPosition % imagesUrls.count
            setViewControllerForPageView(nextControllerIndex)
        }
        else {
            onBackButtonPress()
        }
    }

    
}

extension ImagePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! PagerContentViewController
        if itemController.index > 0 {
            return getItemController(itemController.index - 1)
        }
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        let itemController = viewController as! PagerContentViewController
        if itemController.index + 1 < imagesUrls.count {
            return getItemController(itemController.index + 1)
        }
        return nil
        
    }
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return imagesUrls.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return pageViewController.
//    }
    
    // A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
    // Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
    //     func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int // The number of items reflected in the page indicator.
    //      func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int // The selected item reflected in the page indicator.
    
    func removeItemFromDictionary(index:Int){
         images?.removeValueForKey(index)
        
        for i in index+1..<5{
            if let v = images![i] {
                images?.removeValueForKey(i)
                images![i-1] = v
            }
        }
    }
}

extension ImagePageViewController : UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0] as! PagerContentViewController
        initialPosition = pageContentViewController.index
    }
}

