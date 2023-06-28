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
        
        setURL(id: catID ?? "nil")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageView.load(urlImage)
    }
    
    func setURL(id: String) {
        urlId = "https://api.thecatapi.com/v1/images/search?breed_ids=\(id)"
        imgJson()
    }
    
    func imgJson() {
        guard let url = URL(string: urlId ?? "nil") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    if let decodedJson = try? JSONDecoder().decode([BreadImage].self, from: data) {
                        DispatchQueue.main.async {
                            if let decodedImage = decodedJson.last?.url  {
                                self.urlImage = decodedImage
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
        
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
