//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Next on 01/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PinterestLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
    //checking git
    @IBOutlet weak var mCollectionView: UICollectionView!
    let twoColors:[UIColor] = [UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue,UIColor.red,UIColor.blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout = mCollectionView.collectionViewLayout as! PinterestLayout
        layout.delegate = self
        layout.numberOfColumns = 4
        layout.xInset = 0
        layout.yInset = 0
        layout.xCellSpacing = 2
        layout.yCellSpacing = 5
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random) * 100
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = twoColors[indexPath.row]
        return cell
    }

}

