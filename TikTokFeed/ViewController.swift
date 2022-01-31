//
//  ViewController.swift
//  TikTokFeed
//
//  Created by Nilesh Kumar on 28/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    var data = [model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<10{
          let myModel =  model(caption: "My first Video", userName: "MyUserName", audioTrackName: "MyAudioTrack", videoTrackName: "videoplayback", videoFormat: "mp4")
            data.append(myModel)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataModel = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.config(with: dataModel)
        return cell
    }
    
    
}

struct model{
    
    let caption: String
    let userName: String
    let audioTrackName: String
    let videoTrackName: String
    let videoFormat: String
    
}
