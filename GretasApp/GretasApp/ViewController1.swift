//
//  ViewController1.swift
//  GretasApp
//
//  Created by Evgeniya Tveritinova on 16/11/2019.
//  Copyright © 2019 Daria Zvereva. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

class CheckList : UIStackView {
    class CheckBox : UIButton {
//        var checked = false
        var empty = UIImage(named: "EmptyCheckBox")
        var filled = UIImage(named: "FilledCheckBox")
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setImage(empty, for: .normal)
//            self.checked = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }
    
    class ProTextField : UITextField {
        weak var parent: UIStackView! = nil
        override func deleteBackward() {
            if (self.text != "") {
                super.deleteBackward()
            }
            else {
                parent.removeFromSuperview()
            }
        }
    }
    
    @objc func makeSearch(sender: ProTextField){
    
        let defaults = UserDefaults.standard
        if let data_ = defaults.string(forKey: "current_products") {
            defaults.set(data_+";"+sender.text!+"-0", forKey: "current_products")
        } else {
            defaults.set(sender.text!+"-0", forKey: "current_products")
        }
        
        addTip(forfield: sender)
    }
    
    
    @objc
    func boxChecked(_ sender: UIButton) {
        sender.superview?.superview?.removeFromSuperview()
        let defaults = UserDefaults.standard
//        if let data_ = defaults.string(forKey: "current_products") {
//            defaults.set(data_ + ";" + (sender.superview! as! CheckList).text.text! + "-1", forKey: "current_products")
//        } else {
//            defaults.set((sender.superview! as! CheckList).text.text! + "-1", forKey: "current_products")
//        }
        
        if (sender.superview! as! CheckList).text.text! == "" {
            return
        }
        
        var to_save: Array<String> = []

        if let data_ = defaults.string(forKey: "current_products") {
            let list = Array(data_.split(separator: ";").map(String.init))

                for it in list {
                    let list1 = Array(it.split(separator: "-").map(String.init))
                    
                    let productId = list1[0]
                    let cnt = list1[1]
                    if  productId == (sender.superview! as! CheckList).text.text! {
                        to_save.append(productId+"-1")
                    } else {
                        to_save.append(it)
                    }
                }
            
            

        }
        
        if (to_save.count == 0) {
            to_save.append((sender.superview! as! CheckList).text.text! + "-1")
        }
        
        print(to_save)

        
        defaults.set(to_save.joined(separator: ";"), forKey: "current_products")

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text.addTarget(self, action: #selector(makeSearch), for: .editingDidEndOnExit)
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillProportionally
        
        self.spacing = 10
        
        self.checkBox.addTarget(self, action: #selector(boxChecked), for: .touchUpInside)
        
        self.addArrangedSubview(self.checkBox)
        self.addArrangedSubview(self.text)
        
        self.heightAnchor.constraint(equalToConstant: 25.0).isActive = true

        self.checkBox.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.checkBox.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        self.checkBox.widthAnchor.constraint(equalTo: self.checkBox.heightAnchor).isActive = true
        self.checkBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var checkBox = CheckBox()
    var text = ProTextField()
}


func addTip(forfield: CheckList.ProTextField) {

    let http_client = HttpClient(_baseUrl: "https://kesko.azure-api.net/v1", _token: "3ddca0c4535143e1bdf67a32c216c881")
    let (data, response, error) = http_client.reciveProductCategory(item: forfield.text!)

    let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
    var category: String?
    if let responseJSON = responseJSON as? [String: Any] {
        
        if let results = responseJSON["results"] as? Array<Any> {
            if results.count > 0 {
                if let best_result = results[0] as? [String: Any] {
                    if let subcategory = best_result["subcategory"] as? [String: Any] {
                        category = subcategory["finnish"] as? String
                    }
                }
            }
        }
    }

    if category != nil {
        
        let tipsView = UIStackView()
        tipsView.axis = .horizontal
        tipsView.spacing = 10
        
        let bulbImage = UIImageView(image: UIImage(named: "Bulb.png"))
        let tips = UILabel()
        if category! == "Virvoitusjuomat" {
            tips.text = "Take can instead of plasstic!"
        }
        else if category! == "Hedelmät ja marjat" {
            tips.text = "Don't forget bag!"
        } else {
            return
        }
        let empty3 = UIView()
        empty3.widthAnchor.constraint(equalToConstant: 100).isActive = true
        tipsView.addArrangedSubview(empty3)
        tipsView.addArrangedSubview(bulbImage)
        tipsView.addArrangedSubview(tips)
        tipsView.alignment = .fill
        tipsView.distribution = .fillProportionally
        tipsView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        bulbImage.heightAnchor.constraint(equalTo: tipsView.heightAnchor).isActive = true
        bulbImage.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        bulbImage.widthAnchor.constraint(equalTo: bulbImage.heightAnchor).isActive = true
        bulbImage.leadingAnchor.constraint(equalTo: tipsView.leadingAnchor, constant: 10).isActive = true
        
        forfield.parent.addArrangedSubview(tipsView)
        let empty2 = UIView()
        empty2.heightAnchor.constraint(equalToConstant: 10).isActive = true
        forfield.parent.addArrangedSubview(empty2)

        forfield.parent.spacing = 10
        
        forfield.parent.addBackground(color: UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0))
    }
}





class ViewController1: UIViewController {
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addNewItem: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.axis = .vertical
        
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fill

        scrollView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          // Attaching the content's edges to the scroll view's edges
          stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
          stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
//        let defaults = UserDefaults.standard
//        if let data_ = defaults.string(forKey: "run_out_product") {
//            let to_add = Array(data_.split(separator: ";").map(String.init))
//        }
//        for it in to_add:
//            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        for ch in stackView.arrangedSubviews {
            ch.removeFromSuperview()
        }
        
        if let data_ = defaults.string(forKey: "current_products") {
            print(data_)
            let list = Array(data_.split(separator: ";").map(String.init))
                for it in list {
                    let list1 = Array(it.split(separator: "-").map(String.init))
                    
                    let productId = list1[0]
                    let cnt = list1[1]
                    if cnt == "0" {
                    addItem(text: productId, addTip_: true)
                    }
                }
        }
    }
    
    
    
    @IBAction func addNewItem(_ sender: Any) {
        addItem(text: nil, addTip_: false)
    }
    func addItem(text: String?, addTip_: Bool) {
        
        let newItem = CheckList()
        let newFiled = UIStackView()
        newFiled.axis = .vertical
                
        let empty = UIView()
       empty.heightAnchor.constraint(equalToConstant: 10).isActive = true
//       empty.widthAnchor.constraint(equalToConstant: 15).isActive = true
       newFiled.addArrangedSubview(empty)
        
        newFiled.addArrangedSubview(newItem)
        stackView.addArrangedSubview(newFiled)
        newItem.text.text = text
        newItem.text.parent = newFiled

        if addTip_ {
            addTip(forfield: newItem.text)
        }
    }

    
}
