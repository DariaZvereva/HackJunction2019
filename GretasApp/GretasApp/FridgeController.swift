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
    var productSpoiled: Array<String> = []
    var productRemoved: Array<String> = []
    var allViews: Array<UIView> = []
    var viewIdByButtonTag: [Int: Int] = [:]
    var currentId: Int = 0
    
    func getProductView(product_id: String) -> UIView {
        let view_ = UIView()
        view_.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        view_.backgroundColor = UIColor.opaqueSeparator.withAlphaComponent(0.2)
        let productLabel = UILabel()
        productLabel.text = "\(product_id)"
        productLabel.textAlignment = .center
        
        view_.addSubview(productLabel)
        allViews.append(view_)
        
        productLabel.leftAnchor.constraint(equalTo: view_.leftAnchor, constant: 5).isActive = true
        productLabel.topAnchor.constraint(equalTo: view_.topAnchor, constant: 10).isActive = true
        productLabel.bottomAnchor.constraint(equalTo: view_.bottomAnchor, constant: -10).isActive = true

        productLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let runOutButton = UIButton()
        runOutButton.backgroundColor = UIColor.white
        runOutButton.setTitle("Run out", for: .normal)
        runOutButton.addTarget(self, action: #selector(self.saveProductRunOut), for: .touchUpInside)
        runOutButton.setTitleColor(UIColor.orange, for: UIControl.State.normal)
        runOutButton.titleLabel?.font = UIFont(name: "Helvetica", size:12)
        runOutButton.layer.borderColor = UIColor.black.cgColor
        runOutButton.layer.borderWidth = 1
        view_.addSubview(runOutButton)

        let spoiledButton = UIButton()
        spoiledButton.backgroundColor = UIColor.white
        spoiledButton.setTitle("Spoiled", for: .normal)
        spoiledButton.addTarget(self, action: #selector(saveProductSpoiled), for: .touchUpInside)
        spoiledButton.setTitleColor(UIColor.orange, for: UIControl.State.normal)
        spoiledButton.titleLabel?.font = UIFont(name: "Helvetica", size:12)
        spoiledButton.layer.borderColor = UIColor.black.cgColor
        spoiledButton.layer.borderWidth = 1
        view_.addSubview(spoiledButton)

        runOutButton.leftAnchor.constraint(equalTo: spoiledButton.rightAnchor, constant: 5).isActive = true
        runOutButton.rightAnchor.constraint(equalTo: view_.rightAnchor, constant: -10).isActive = true
        runOutButton.topAnchor.constraint(equalTo: view_.topAnchor, constant: 10).isActive = true
        runOutButton.bottomAnchor.constraint(equalTo: view_.bottomAnchor, constant: -10).isActive = true
        runOutButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        runOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        runOutButton.tag = currentId
        viewIdByButtonTag[currentId] = allViews.count - 1
        productIdByButtonId[currentId] = product_id
        currentId += 1
                
        spoiledButton.leftAnchor.constraint(equalTo: productLabel.rightAnchor, constant: 5).isActive = true
        spoiledButton.rightAnchor.constraint(equalTo: runOutButton.leftAnchor, constant: -5).isActive = true
        spoiledButton.topAnchor.constraint(equalTo: view_.topAnchor, constant: 10).isActive = true
        spoiledButton.bottomAnchor.constraint(equalTo: view_.bottomAnchor, constant: -10).isActive = true
        spoiledButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        spoiledButton.translatesAutoresizingMaskIntoConstraints = false
        
        spoiledButton.tag = currentId
        productIdByButtonId[currentId] = product_id
        viewIdByButtonTag[currentId] = allViews.count - 1
        currentId += 1

        return view_
    }
    
    @objc
    func saveProductRunOut(sender: UIButton) {
        print("Product \(productIdByButtonId[sender.tag]) run out")
        productRemoved.append(productIdByButtonId[sender.tag]!)
        let num = viewIdByButtonTag[sender.tag]
        let view_to_remove = allViews[num!]
        productsStackView.removeArrangedSubview(view_to_remove)
        view_to_remove.removeFromSuperview()
    }
    
    @objc
    func saveProductSpoiled(sender: UIButton) {
        print("Product \(productIdByButtonId[sender.tag]) spoiled")
        productSpoiled.append(productIdByButtonId[sender.tag]!)
        let num = viewIdByButtonTag[sender.tag]
        let view_to_remove = allViews[num!]
        productsStackView.removeArrangedSubview(view_to_remove)
        view_to_remove.removeFromSuperview()
    }
    
    // TODO: Get Actual
    func getProducts() -> Array<String> {
        return ["Bread", "Banana", "Eggs", "Milk", "A Very Long Long Product", "Banana", "Bread", "Eggs", "Milk", "A Very Long Long Product", "Banana", "Bread", "Eggs", "Milk", "A Very Long Long Product"]
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
        productsStackView.distribution = .equalSpacing
        productsStackView.alignment = .trailing
        let products = getProducts()
               for product in products {
                   let prod = getProductView(product_id: product)
                   productsStackView.addArrangedSubview(prod)
                    prod.trailingAnchor.constraint(equalTo: productsStackView.trailingAnchor, constant: -5).isActive = true
                    prod.leadingAnchor.constraint(equalTo: productsStackView.leadingAnchor, constant: 5).isActive = true
               }
        
        let space = UIView()
        space.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        space.translatesAutoresizingMaskIntoConstraints = false
        productsStackView.addArrangedSubview(space)
        space.widthAnchor.constraint(equalTo: productsStackView.widthAnchor).isActive = true

        let imageName = "20.png"
        let image = UIImage(named: imageName)
        let whaleImg = UIImageView(image: image!)
        whaleImg.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        whaleImg.widthAnchor.constraint(equalTo: whaleImg.heightAnchor).isActive = true
        whaleImg.translatesAutoresizingMaskIntoConstraints = false
        productsStackView.addArrangedSubview(whaleImg)
    }
}
