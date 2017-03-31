//
//  PhotoDetailViewController.swift
//  BoosterKit
//
//  Created by Travis Palmer on 12/2/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import Foundation

class PhotoDetailViewController: UIViewController {

    var photo: Photo
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        self.photo = Photo()

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        self.titleLabel.text = self.photo.title

        let url = NSURL(string: self.photo.url)! as URL
        let data = NSData(contentsOf: url)! as Data
        let image = UIImage(data : data)

        self.imageView.image = image
    }
}
