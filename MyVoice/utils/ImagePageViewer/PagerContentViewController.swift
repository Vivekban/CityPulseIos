//
//  PagerContentViewController.swift
//  MyVoice
//
//  Created by PB014 on 19/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol PagerContentDelegate{
    func onBackButtonPress()
    func onDeleteButtonPress(index: Int)
}

class PagerContentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var imageName:String = "" {
        didSet{
            loadImage()
        }
    }
    
    var image:UIImage?
    
    var index:Int = 0
    var delegate:PagerContentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImage(){
        
        if imageView != nil{
            
            if !imageName.isEmpty{
                ServerImageFetcher.i.loadImageWithDefaultsIn(imageView, url: imageName)
            }
            else if image != nil {
            imageView.image = image
            }
        }
    
    }
    
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
