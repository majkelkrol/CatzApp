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
    @IBOutlet var temperamentLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var catImage: UIImage?
    var catID: String?
    var catName: String?
    var catTemperament: String?
    var carOrigin: String?
    var catDescription: String?
    
    var networkingManager = NetworkingManager()
    var url = [BreadImage]()
    var urlId: String?
    var urlString: String?
    var urlImage: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = catName

        if let id = catID {
            idLabel.text = "ID: \(id)"
        }
        
        if let temp = catTemperament {
            temperamentLabel.text = "Temperament: \(temp)"
        }

        if let origin = carOrigin {
            originLabel.text = "Origin: \(origin)"
        }

        descriptionLabel.text = catDescription
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkingManager.getBreadImage(id: catID ?? "nil") { breadImage in
            DispatchQueue.main.async {
                if let decodedImage = breadImage.last?.url  {
                    self.urlImage = decodedImage
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageView.load(urlImage)
    }
}

extension UIImageView {
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
