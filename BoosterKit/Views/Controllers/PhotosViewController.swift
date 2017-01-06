//
//  PhotosViewController.swift
//  BoosterKit
//
//  Created by Travis Palmer on 10/21/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import UIKit
import RealmSwift


class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct Constants {
        static let photoDetailSegueId = "photoDetailSegue"
    }
    
    enum PhotosViewControllerError: Error {
        case invalidThumbnail
    }
    
    @IBOutlet var tableView: UITableView!
    var photos: Results<Photo> {
        didSet {
            // Ensure we're reloading in the main thread,
            // otherwise the tableview won't properly reload.
            DispatchQueue.main.async {
                NSLog("Reloading tableView.")
                self.tableView.reloadData()
            }
        }
    }
    var selectedCellIndex: Int
    
    
    required init?(coder aDecoder: NSCoder) {
        
        let realm = try! Realm()
        self.photos = realm.objects(Photo.self)
        self.selectedCellIndex = 0
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // We're using the trailing closure syntax here:
        // http://tinyurl.com/gnm3noo
        APIManager.fetchData() {
            // Get realm and table instances for the main thread.
            let realm = try! Realm()
            self.photos = realm.objects(Photo.self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.photoDetailSegueId {
            let destinationViewController = segue.destination as! PhotoDetailViewController
            destinationViewController.photo = self.photos[self.selectedCellIndex]
        }
    }

    func populateCell(cell: UITableViewCell, indexPath: IndexPath) throws -> UITableViewCell {
        
        let photo = self.photos[indexPath.row]
        
        cell.textLabel?.text = photo.title
        
        let url = NSURL(string: photo.thumbnailUrl) as! URL
        guard let data = NSData(contentsOf: url) else {
            throw PhotosViewControllerError.invalidThumbnail
        }
        let image = UIImage(data : data as Data)
        
        cell.imageView?.image = image

        
        return cell
    }
    
    // MARK: UITableView delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "photoCell")! as UITableViewCell
        
        do {
            try cell = populateCell(cell: cell, indexPath: indexPath)
        }
        catch PhotosViewControllerError.invalidThumbnail {
            cell.imageView?.image = nil
        }
        catch {
            NSLog("Error populating cell: \(error)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCellIndex = indexPath.row
        self.performSegue(withIdentifier: Constants.photoDetailSegueId, sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.photos.count
    }
}

