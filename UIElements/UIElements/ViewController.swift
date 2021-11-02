//
//  ViewController.swift
//  UIElements
//
//  Created by Abhiram Krishna on 27/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    var image = "https://i.pinimg.com/originals/1a/3e/73/1a3e733334ec8948b0328af4e5b7288a.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.load(urlString: image)
    }
}

extension UIImageView {
    func  load(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            [weak self] in
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
