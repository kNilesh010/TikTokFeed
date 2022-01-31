//
//  MyCollectionViewCell.swift
//  MyCollectionViewCell
//
//  Created by Nilesh Kumar on 28/01/22.
//

import UIKit
import AVFoundation

protocol MyCollectionViewCellDelegate: AnyObject{
    func didTapShare(with model: model)
    func didTapProfile(with model: model)
    func didTapLike(with model: model)
    func didTapComment(with model: model)
}

class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    var player: AVPlayer?
    
    private var model: model?
    
    private let caption: UILabel = {
        let caption = UILabel()
        caption.textColor = .white
        caption.textAlignment = .left
        return caption
    }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.textColor = .white
        userName.textAlignment = .left
        return userName
    }()
    
    private let audioLabel: UILabel = {
        let audioLabel = UILabel()
        audioLabel.textColor = .white
        audioLabel.textAlignment = .left
        return audioLabel
    }()
    
    private let share: UIButton = {
        let share = UIButton()
        share.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.forward.fill"), for: .normal)
        return share
    }()
    
    private let profile: UIButton = {
        let profile = UIButton()
        profile.setBackgroundImage(UIImage(systemName: "person"), for: .normal)
        return profile
    }()

    private let like: UIButton = {
        let like = UIButton()
        like.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        return like
    }()

    private let comment: UIButton = {
        let comment = UIButton()
        comment.setBackgroundImage(UIImage(systemName: "message"), for: .normal)
        return comment
    }()
    
    private let videoView = UIView()

    var delegate: MyCollectionViewCellDelegate?
    
    
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        
        contentView.addSubview(videoView)
        videoView.clipsToBounds = true
        contentView.sendSubviewToBack(videoView)
        
        contentView.backgroundColor = .blue
        contentView.clipsToBounds = true
        
        contentView.addSubview(caption)
        contentView.addSubview(userName)
        contentView.addSubview(audioLabel)
        
        contentView.addSubview(share)
        contentView.addSubview(profile)
        contentView.addSubview(like)
        contentView.addSubview(comment)
        
        
        share.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        share.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        share.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        share.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func shareButtonTapped(){
        guard let model = model else {
            return
        }
        delegate?.didTapShare(with: model)
    }
    
    @objc func profileButtonTapped(){
        guard let model = model else {
            return
        }
        delegate?.didTapProfile(with: model)
    }
    
    @objc func likeButtonTapped(){
        guard let model = model else {
            return
        }
        delegate?.didTapLike(with: model)
    }
    
    @objc func commentButtonTapped(){
        guard let model = model else {
            return
        }
        delegate?.didTapComment(with: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoView.frame = contentView.bounds
        
        let size = contentView.frame.size.width / 8
        
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100
        
        profile.frame = CGRect(x: width - size, y: height - size, width: size, height: size)
        like.frame = CGRect(x: width - size, y: height - (size * 2) - 20, width: size, height: size)
        share.frame = CGRect(x: width - size, y: height - (size * 3) - 40, width: size, height: size)
        comment.frame = CGRect(x: width - size, y: height - (size * 4) - 60, width: size, height: size)
        
        caption.frame = CGRect(x: 20, y: height - 50, width: width - size - 10, height: 50)
        userName.frame = CGRect(x: 20, y: height - 100, width: width - size - 10, height: 50)
        audioLabel.frame = CGRect(x: 20, y: height - 150, width: width - size - 10, height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        caption.text = nil
        userName.text = nil
        audioLabel.text = nil
    }
    
    
    func config(with model: model){
        self.model = model
        configureVideo()
        
        caption.text = model.caption
        userName.text = model.userName
        audioLabel.text = model.audioTrackName
        
    }
    
    func configureVideo(){
        guard let model = model else {
            return
        }

        guard let videoPath = Bundle.main.path(forResource: model.videoTrackName, ofType: model.videoFormat) else {
            print("failed to load video")
            print("\(model.videoFormat)")
            return
            
        }
         let url = URL(fileURLWithPath: videoPath)
        
        player = AVPlayer(url: url)
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.videoGravity = .resizeAspectFill
        playerView.frame = contentView.bounds
        videoView.layer.addSublayer(playerView)
        
        player?.volume = 0
        player?.play()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
