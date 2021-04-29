//
//  SearchTableViewCell.swift
//  tmobile
//
//  Created by naga vineel golla on 4/23/21.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = Constants.identifier
    
    var redditImage:  UIImageView = {
    let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var redditTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    var comment: UILabel = {
        let comment = UILabel()
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.textAlignment = .center
        return comment
    }()
    
    var score: UILabel = {
        let score = UILabel()
        score.translatesAutoresizingMaskIntoConstraints = false
        score.textAlignment = .center
        return score
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
           config()
    }
    
    override func prepareForReuse() {
        comment.text = ""
        score.text = ""
        redditTitle.text = ""
        redditImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        contentView.addSubview(redditTitle)
        contentView.addSubview(redditImage)
        contentView.addSubview(comment)
        contentView.addSubview(score)
        
        NSLayoutConstraint.activate([redditTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                                       redditTitle.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
                                       redditTitle.heightAnchor.constraint(equalToConstant: 80),
                                       redditTitle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15)])
        
        NSLayoutConstraint.activate([comment.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                                     comment.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                                     comment.rightAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                                     comment.heightAnchor.constraint(equalToConstant: 40)])
        
        NSLayoutConstraint.activate([score.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                                    score.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                                    score.leftAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                                    score.heightAnchor.constraint(equalToConstant: 40)])
    
        NSLayoutConstraint.activate([redditImage.topAnchor.constraint(equalTo: redditTitle.bottomAnchor),
                                       redditImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                                       redditImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                                       redditImage.bottomAnchor.constraint(equalTo: comment.topAnchor)])
    }
}
