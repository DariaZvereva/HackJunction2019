//
//  FridgeController.swift
//  GretasApp
//
//  Created by Daria Zvereva on 16/11/2019.
//  Copyright © 2019 Daria Zvereva. All rights reserved.
//

import UIKit

class FridgeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var productsStackView: UIStackView!
    
    @IBAction func addProduct(_ sender: Any) {
        let view1 = UIView(frame: CGRect(x: 100, y: 50, width: 100, height: 100))
        view1.backgroundColor = UIColor.red
        productsStackView.addArrangedSubview(view1)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
