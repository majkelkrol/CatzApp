//
//  DetailCatzController.swift
//  CatzApp
//
//  Created by Majkel on 22/06/2023.
//

import UIKit

class CatDetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var temperamentLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var catImage: UIImage?
    var catID: String?
    var catName: String?
    var catTemperament: String?
    var carOrigin: String?
    var catDescription: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idLabel.text = catID
        nameLabel.text = catName
        temperamentLabel.text = catTemperament
        originLabel.text = carOrigin
        descriptionLabel.text = catDescription
    }

}
