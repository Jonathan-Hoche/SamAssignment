//
//  GeonameTableViewCell.swift
//  WIkiSAM_JonathanHoch
//
//  Created by Jonathan Hoche on 14/05/2021.
//

import UIKit

class GeonameTableViewCell: UITableViewCell, Reusable, NibLoadable {
    
    @IBOutlet weak private var thumbnailImageView: CircleImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var summaryLabel: UILabel!

    func configure(with geoname: Geoname) {
        updateThumbnailImage(with: geoname.thumbnailImgData)
        titleLabel.text = geoname.title
        summaryLabel.text = geoname.summary
    }
    
    func updateThumbnailImage(with data: Data?) {
        if let data = data {
            thumbnailImageView.image = UIImage(data: data)
        } else {
            thumbnailImageView.image = UIImage(systemName: "crop")
        }
    }
}
