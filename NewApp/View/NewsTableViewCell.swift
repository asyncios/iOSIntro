//
//  NewsTableViewCell.swift
//  NewApp
//
//  Created by josue cadillo on 3/31/17.
//  Copyright © 2017 FandangoLatam. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let NIB_NAME = "NewsTableViewCell"
    
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var newsLabel: UILabel!
    @IBOutlet var imageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(news: News)
    {
        if news.mainImage?.url != nil
        {
            self.newsImageView.customSetImage(url: Util.setImageUrl(string: (news.mainImage?.url)!,
                                                                    height: Double(imageViewHeightConstraint.constant)))
        }
        self.newsLabel.text = news.title
        
    }

}
