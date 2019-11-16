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
    
    var productIdByButtonId: [Int: String] = [:]

    var currentId: Int = 0
    
    func getAllProducts() -> [String: Any] {
        return [:]
    }
    
    func getProductView(product_id: String) -> UIView {
        let view_ = UIView()
        view_.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        view_.backgroundColor = .opaqueSeparator
        let productLabel = UILabel()
        productLabel.backgroundColor = .white
        productLabel.text = "I'm label \(product_id)."
        productLabel.textAlignment = .center
        
        view_.addSubview(productLabel)
        
        productLabel.leftAnchor.constraint(equalTo: view_.leftAnchor, constant: 10).isActive = true
        productLabel.topAnchor.constraint(equalTo: view_.topAnchor, constant: 10).isActive = true
        productLabel.bottomAnchor.constraint(equalTo: view_.bottomAnchor, constant: -10).isActive = true

        productLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let runOutButton = UIButton()
        runOutButton.backgroundColor = UIColor.red
        runOutButton.setTitle("Run out", for: .normal)
        runOutButton.addTarget(self, action: #selector(self.saveProductRunOut), for: .touchUpInside)
        view_.addSubview(runOutButton)

        var spoiledButton = UIButton()
        spoiledButton.backgroundColor = UIColor.black
        spoiledButton.setTitle("Spoiled", for: .normal)
        spoiledButton.addTarget(self, action: #selector(saveProductSpoiled), for: .touchUpInside)
        view_.addSubview(spoiledButton)

        runOutButton.leftAnchor.constraint(equalTo: spoiledButton.rightAnchor, constant: 10).isActive = true
        runOutButton.rightAnchor.constraint(equalTo: view_.rightAnchor, constant: -10).isActive = true
        runOutButton.topAnchor.constraint(equalTo: view_.topAnchor, constant: 10).isActive = true
        runOutButton.bottomAnchor.constraint(equalTo: view_.bottomAnchor, constant: -10).isActive = true
        runOutButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        runOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        runOutButton.tag = currentId
        productIdByButtonId[currentId] = product_id
        currentId += 1

                
        spoiledButton.leftAnchor.constraint(equalTo: productLabel.rightAnchor, constant: 10).isActive = true
        spoiledButton.rightAnchor.constraint(equalTo: runOutButton.leftAnchor, constant: -10).isActive = true
        spoiledButton.topAnchor.constraint(equalTo: view_.topAnchor, constant: 10).isActive = true
        spoiledButton.bottomAnchor.constraint(equalTo: view_.bottomAnchor, constant: -10).isActive = true
        spoiledButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        spoiledButton.translatesAutoresizingMaskIntoConstraints = false
        
        spoiledButton.tag = currentId
        productIdByButtonId[currentId] = product_id
        currentId += 1


        return view_
    }
    
    @objc
    func saveProductRunOut(sender: UIButton) {
        print("Product \(productIdByButtonId[sender.tag]) run out")
    }
    
    @objc
    func saveProductSpoiled(sender: UIButton) {
        print("Product \(productIdByButtonId[sender.tag]) spoiled")
    }
    
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
        let prod_2 = getProductView(product_id: NSDate().description)
        productsStackView.addArrangedSubview(prod_2)
    }

}
