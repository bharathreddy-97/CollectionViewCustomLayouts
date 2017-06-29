//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Next on 01/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,PinterestLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
    //checking git
    @IBOutlet weak var mCollectionView: UICollectionView!
    let photos:[UIImage] = [#imageLiteral(resourceName: "kidImage.jpeg"),#imageLiteral(resourceName: "kidImage2.jpg"),#imageLiteral(resourceName: "login-bg.png"),#imageLiteral(resourceName: "Simulator Screen Shot 19-Jun-2017, 2.45.01 PM.png"),#imageLiteral(resourceName: "kidImage.jpeg"),#imageLiteral(resourceName: "kidImage2.jpg"),#imageLiteral(resourceName: "login-bg.png"),#imageLiteral(resourceName: "Simulator Screen Shot 19-Jun-2017, 2.45.01 PM.png"),#imageLiteral(resourceName: "kidImage.jpeg"),#imageLiteral(resourceName: "kidImage2.jpg"),#imageLiteral(resourceName: "login-bg.png"),#imageLiteral(resourceName: "Simulator Screen Shot 19-Jun-2017, 2.45.01 PM.png"),#imageLiteral(resourceName: "kidImage.jpeg"),#imageLiteral(resourceName: "kidImage2.jpg"),#imageLiteral(resourceName: "login-bg.png"),#imageLiteral(resourceName: "Simulator Screen Shot 19-Jun-2017, 2.45.01 PM.png"),#imageLiteral(resourceName: "kidImage.jpeg"),#imageLiteral(resourceName: "kidImage2.jpg"),#imageLiteral(resourceName: "login-bg.png"),#imageLiteral(resourceName: "Simulator Screen Shot 19-Jun-2017, 2.45.01 PM.png")]
    let captions:[String] = ["Muggle Harry Potter","Uninterested Student","Interested students","Some Simulator shit image","Muggle Harry Potter","Uninterested Student","Interested students","Some Simulator shit image","Muggle Harry Potter","Uninterested Student","Interested students","Some Simulator shit image","Muggle Harry Potter","Uninterested Student","Interested students","Some Simulator shit image","Muggle Harry Potter","Uninterested Student","Interested students","Some Simulator shit image"]
    //let twoColors:[UIColor] = [UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout = mCollectionView.collectionViewLayout as! PinterestLayout
        layout.delegate = self
        layout.numberOfColumns = 2
        layout.xInset = 5
        layout.yInset = 0
        layout.xCellSpacing = 5
        layout.yCellSpacing = 5
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return 60
    }
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let photoWidth = photo.size.width
        let photoHeight = photo.size.height
        
        let aspectRatio = photoWidth/photoHeight
        return width/aspectRatio
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PinterestCell
        //cell.backgroundColor = twoColors[indexPath.row]
        cell.mImageView.image = photos[indexPath.item]
        cell.mCaptionLabel.text = captions[indexPath.item]
        return cell
    }

}

