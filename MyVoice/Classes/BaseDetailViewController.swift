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
    var scrollView:UIScrollView!
    
    weak var delegate:BaseDetaiViewControllerDelegate?
    
    var heightContraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel =  view.viewWithTag(1) as! UILabel
        editButton =  view.viewWithTag(2) as! UIButton
        
        scrollView = view.viewWithTag(99) as! UIScrollView
        let container = view.viewWithTag(100)
        //container?.translatesAutoresizingMaskIntoConstraints = false
        for c in (container?.constraints)! {
            
            if c.identifier == "containerHeight" {
                heightContraint = c
            }
        }

        
        scrollView.canCancelContentTouches = false
        //scrollView.delaysContentTouches
        
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
            dateLabel.text = d.disPlayDate
        }
        descriptionLabel.sizeToFit()
        fetchMoreDetailFromServer()
    }
    
    func fetchMoreDetailFromServer(){
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = scrollView.contentSize
        
        //  MyUtils.createShadowOnView(descriptionLabel)
        
        scrollView.contentSize = CGSizeMake(size.width, size.height + max(0, descriptionLabel.frame.height - 100))
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

class BaseCommentDetailViewController: BaseDetailViewController {
    var comments:[CommentData] = [CommentData]()
    var commentView:UIView?
    var commentController:CommentController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentView = view.viewWithTag(999)
        if commentView != nil {
            commentController = CommentController(frame: CGRectMake(0, 0, (commentView?.frame.width)!, 500), data: comments)
            commentController?.tableView.canCancelContentTouches = false
            commentView!.addSubview(commentController!)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        log.info("bound before change\(view.viewWithTag(100)!.frame.size.height)")
        commentView?.frame.size.height = (commentController?.getHeightOfView())!

        commentController?.tableView.frame.size.height = (commentView?.frame.height)!
        scrollView.contentSize.height += (commentView?.frame.size.height)!
        heightContraint.constant = scrollView.contentSize.height
        
        //view.viewWithTag(100)!.frame.size.height = scrollView.contentSize.height;
        log.info("bound after change\(view.viewWithTag(100)!.frame.size.height)")
        view.layoutIfNeeded()
    }
    
}



class BaseImageDetailViewController: BaseCommentDetailViewController {
    
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


class TestingView : UIView {
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let b = super.pointInside(point, withEvent: event)
        log.info("\(point) .......is prsent ...........\(b)..")
        return b
    }
}
