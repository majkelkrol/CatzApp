//
//  ViewController.swift
//  CatzApp
//
//  Created by Majkel on 21/06/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var breads = [Bread]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        JSON()
    }
    
    func setup() {
        title = "CatzApp"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func JSON() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedJson = try JSONDecoder().decode([Bread].self, from: data)
                    DispatchQueue.main.async {
                        self.breads.append(contentsOf: decodedJson)
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = breads[indexPath.row].name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "catDetailVC") as! CatDetailViewController
        vc.catID = breads[indexPath.row].id
        vc.catName = breads[indexPath.row].name
        vc.catTemperament = breads[indexPath.row].temperament
        vc.carOrigin = breads[indexPath.row].origin
        vc.catDescription = breads[indexPath.row].description
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

