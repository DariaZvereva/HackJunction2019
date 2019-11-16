//
//  FridgeController.swift
//  GretasApp
//
//  Created by Daria Zvereva on 16/11/2019.
//  Copyright © 2019 Daria Zvereva. All rights reserved.
//

import UIKit


class FridgeController: UIViewController {

    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var productsStackView: UIStackView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.addSubview(self.productsStackView)
    self.productsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          // Attaching the content's edges to the scroll view's edges
          productsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          productsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
          productsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          productsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

          // Satisfying size constraints
          productsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    @IBAction func addProduct(_ sender: Any) {
//        let view1 = UIView(frame: CGRect(x: 100, y: 50, width: 100, height: 100))
//        view1.backgroundColor = UIColor.red
//        productsStackView.addArrangedSubview(view1)
        let greenView = UIView()
        greenView.backgroundColor = .green
        productsStackView.addArrangedSubview(greenView)
        greenView.translatesAutoresizingMaskIntoConstraints = false
        // Doesn't have intrinsic content size, so we have to provide the height at least
        greenView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // Label (has instrinsic content size)
        let label = UILabel()
        label.backgroundColor = .orange
        label.text = "I'm label \(self.productsStackView.subviews.count)."
        label.textAlignment = .center
        productsStackView.addArrangedSubview(label)
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
