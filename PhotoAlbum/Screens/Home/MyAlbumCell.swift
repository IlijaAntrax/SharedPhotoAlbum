//
//  MyAlbumCell.swift
//  PhotoAlbum
//
//  Created by Ilija Antonijevic on 5/9/18.
//  Copyright © 2018 Ilija Antonijevic. All rights reserved.
//

import Foundation
import UIKit

class MyAlbumCell:AlbumCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var peopleCountLbl:UILabel!
    
    @IBOutlet weak var albumUsersCollection: UICollectionView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        peopleCountLbl.font = Settings.sharedInstance.fontRegularSizeSmall()
        peopleCountLbl.textColor = Settings.sharedInstance.fontColorGrayLight()
        
        albumUsersCollection.delegate = self
        albumUsersCollection.dataSource = self
    }
    
    override func setup(album: PhotoAlbum)
    {
        super.setup(album: album)
        
        super.addMask()
        
        if let myAlbum = album as? MyPhotoAlbum
        {
            self.peopleCountLbl.text = "shared with \(myAlbum.albumUsers.count) people" //TODO: add album users on album and setup cells
        }
    }

    var usersList:[FirebaseUser] = [FirebaseUser]()
    {
        didSet
        {
            //TODO: set constraints to collectio depends of number of users
            self.albumUsersCollection.reloadData()
        }
    }
    
    @IBAction func addUserBtnPressed(_ sender: Any)
    {
        //TODO: show add users for album
        self.addNew()
    }
    
    override func addNew()
    {
        //add new user on album, send notification show add users screen
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: NotificationPhotosAddedToAlbum), object: self.album)
    }
    
    //MARK: Collection view delegate, data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirebaseUserCell", for: indexPath) as! FirebaseUserCell
        
        //cell.user = usersList[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("User selected")
        //TODO: show profile, feature
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.frame.height
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
