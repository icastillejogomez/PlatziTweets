//
//  TweetTableViewCell.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 07/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import UIKit
import Kingfisher

class TweetTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
        self.avatarImageView.layer.borderWidth = 1
        self.avatarImageView.layer.borderColor = UIColor.black.cgColor
        self.avatarImageView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    // MARK: - Public methods
    
    public func setupCell(post: Post) {
        // Setup common data
        self.nameLabel.text = post.author.names
        self.nicknameLabel.text = post.author.nickname
        self.tweetLabel.text = post.text
        self.createdAtLabel.text = post.createdAt
        
        // Check image
        if post.hasImage {
            self.tweetImageView.kf.setImage(with: URL(string: post.imageUrl))
        } else {
            self.tweetImageView.isHidden = true // Ocultamos la imagen porque el post no tiene imagen
        }
        
        // Check video
        if post.hasVideo {
            self.setupCellVideo(post.videoUrl)
        } else {
            self.videoButton.isHidden = true // Ocultamos el boton de video
        }
    }
    
    // MARK: - Private methods
    
    private func setupCellVideo (_ videoUrl: String) {
        // Setup video
        // TODO
    }
}
