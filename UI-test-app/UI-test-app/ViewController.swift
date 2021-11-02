//
//  ViewController.swift
//  UI-test-app
//
//  Created by Abhiram Krishna on 19/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!
    var leftScore = 0
    var rightScore = 0
    
    override func loadView() {
        super.loadView()
        print("Entered loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dealTapped(_ sender: Any) {
        let leftNumber = Int.random(in: 2...14)
        let rightNumber = Int.random(in: 2...14)
        leftImageView.image = UIImage(named: "card\(leftNumber)")
        rightImageView.image = UIImage(named: "card\(rightNumber)")
        if leftNumber > rightNumber {
            leftScore += 1
            leftScoreLabel.text = "\(leftScore)"
        }
        else if rightNumber > leftNumber {
            rightScore += 1
            rightScoreLabel.text = "\(rightScore)"
        }
    }
    
    // MARK: - Hello World
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leftImageView.image = UIImage(named: "card14")
        rightImageView.image = UIImage(named: "card14")
        print("Entered viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Entered viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Entered viewDidDisappear")
    }
    
}

