//
//  BaseDetailViewController.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


protocol BaseDetaiViewControllerDelegate : class{
    func onEditButtonClick(index:Int)
}

class BaseDetailViewController: UIViewController {
    
    //MARK: data source fields
    var data:BaseData?
    var dataArray:[BaseData]?
    var dataIndex = 0
    
    //MARK: UI parameters
    var titleLabel: UILabel!
    var editButton: UIButton!
    var dateLabel: UILabel!
    var descriptionLabel: UILabel!
    
    weak var delegate:BaseDetaiViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel =  view.viewWithTag(1) as! UILabel
        editButton =  view.viewWithTag(2) as! UIButton
        
        editButton.addTarget(self, action: "onEditButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        dateLabel =  view.viewWithTag(3) as! UILabel
        descriptionLabel =  view.viewWithTag(4) as! UILabel
        
        
        let myNavigationItem = (self.view.viewWithTag(10) as? UINavigationBar)?.items![0]
         let item = myNavigationItem?.leftBarButtonItems![0]
        item?.action = "onBackButtonClick"
        item?.target = self

        // Do any additional setup after loading the view.
    }
    
    func setDataSourceWith(data :[BaseData]?, index:Int){
        self.data = data![index]
        self.dataArray = data
        self.dataIndex = index
        
        if let d = self.data as? TitleDesDateData {
            titleLabel.text = d.title
            descriptionLabel.text = d.description
            dateLabel.text = d.date
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func onEditButtonClick(){
        delegate?.onEditButtonClick(dataIndex)
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    func onBackButtonClick(){
        dismissViewControllerAnimated(true, completion: nil)

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




class BaseImageDetailViewController: BaseDetailViewController {
    
    var largeImageView:UIImageView!
    var collectionView:UICollectionView!
    
    let cellResueIndentifier = "ImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        largeImageView = view.viewWithTag(5) as! UIImageView

        collectionView = view.viewWithTag(6) as! UICollectionView
    }
    
    override func setDataSourceWith(data: [BaseData]?, index: Int) {
        super.setDataSourceWith(data, index: index)
        
        //setInitialLargeImage
        onItemClick(0)
    }
}


extension BaseImageDetailViewController : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let d = data as? ImageUrlData {
            return d.imagesUrls.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellResueIndentifier, forIndexPath: indexPath)
        
        let view = cell.viewWithTag(1)
        if let iv = view as? UIImageView {
            loadImageInImageView(iv, index: indexPath.row)
        }

//        view?.gestureRecognizers?.removeAll()
//        view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onItemClick:"))
        
        return cell
    }
    
    func  loadImageInImageView(view:UIImageView, index:Int) {
        if let d = data as? ImageUrlData {
            ServerImageFetcher.i.loadImageWithDefaultsIn(view, url: d.imagesUrls[0])
        }
    }
    
    func onItemClick(index:Int){
        if let d = self.data as? ImageUrlData {
            if index < d.imagesUrls.count {
                ServerImageFetcher.i.loadImageWithDefaultsIn(largeImageView, url: d.imagesUrls[index])

            }
            else{
                //TODO: impelement default image
            }
        }
    }
}

extension BaseImageDetailViewController: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        onItemClick(indexPath.row)
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
