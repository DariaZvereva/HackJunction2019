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
        var checked = false
        var empty = UIImage(named: "EmptyCheckBox")
        var filled = UIImage(named: "FilledCheckBox")
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setImage(empty, for: .normal)
            self.checked = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if (!self.checked) {
                self.setImage(self.filled, for: .normal)
                self.checked = true
            } else {
                self.setImage(self.empty, for: .normal)
                self.checked = false
            }
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
        let http_client = HttpClient(_baseUrl: "https://kesko.azure-api.net/v1", _token: "3ddca0c4535143e1bdf67a32c216c881")
        let (data, response, error) = http_client.reciveProductCategory(item: sender.text!)
        let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
        var category: String?
        if let responseJSON = responseJSON as? [String: Any] {
//            print("JSON BEGIN")
//            print(responseJSON)
//            print("JSON END")
            
            if let results = responseJSON["results"] as? Array<Any> {
//                print(1111)
//                print(results)
                if results.count > 0 {
                    if let best_result = results[0] as? [String: Any] {
//                        print(2222)
//                        print(best_result)
                        if let subcategory = best_result["subcategory"] as? [String: Any] {
//                            print(3333)
                            category = subcategory["finnish"] as? String
                            print(category)
                        }
                    }
                }
            }
        }
        if category != nil {
//            sender.parent.
            let tipsView = UIStackView()
            tipsView.axis = .horizontal
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
            tipsView.addArrangedSubview(bulbImage)
            tipsView.addArrangedSubview(tips)
            tipsView.alignment = .fill
            tipsView.distribution = .fillProportionally
            tipsView.spacing = 10
            tipsView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
            
            bulbImage.heightAnchor.constraint(equalTo: tipsView.heightAnchor).isActive = true
            bulbImage.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
            bulbImage.widthAnchor.constraint(equalTo: bulbImage.heightAnchor).isActive = true
            bulbImage.leadingAnchor.constraint(equalTo: tipsView.leadingAnchor, constant: 10).isActive = true
            
            
            sender.parent.addArrangedSubview(tipsView)
        }
//        return category
    }
    
    var checkBox = CheckBox()
    var text = ProTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let checkBox = CheckBox()
//        let text = ProTextField()
        self.text.addTarget(self, action: #selector(makeSearch), for: .editingDidEndOnExit)
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 10
        
        self.addArrangedSubview(self.checkBox)
        self.addArrangedSubview(self.text)
//        self.addSubview(checkBox)
//        text.parent = self
        
        self.addBackground(color: .orange)
        self.heightAnchor.constraint(equalToConstant: 25.0).isActive = true

        self.checkBox.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.checkBox.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        self.checkBox.widthAnchor.constraint(equalTo: self.checkBox.heightAnchor).isActive = true
        self.checkBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//        checkBox.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        
    }
    
    
    
    @IBAction func addNewItem(_ sender: Any) {
//        let tipsView = UIStackView()
//        tipsView.axis = .horizontal
        
//        let bulbImage = UIImageView(image: UIImage(named: "Bulb.png"))
//        let tips = UILabel()
//        tips.text = "Take bags"
//        tipsView.addArrangedSubview(bulbImage)
//        tipsView.addArrangedSubview(tips)
//        tipsView.alignment = .fill
//        tipsView.distribution = .fillProportionally
//        tipsView.spacing = 10
//        tipsView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
//
//        bulbImage.heightAnchor.constraint(equalTo: tipsView.heightAnchor).isActive = true
//        bulbImage.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
//        bulbImage.widthAnchor.constraint(equalTo: bulbImage.heightAnchor).isActive = true
//        bulbImage.leadingAnchor.constraint(equalTo: tipsView.leadingAnchor, constant: 10).isActive = true
//
        
        let newItem = CheckList()
        let newFiled = UIStackView()
        newFiled.axis = .vertical
        newFiled.addArrangedSubview(newItem)
//        newFiled.addArrangedSubview(tipsView)
        newFiled.addBackground(color: .orange)
        stackView.addArrangedSubview(newFiled)
        
        newItem.text.parent = newFiled
//        stackView.addArrangedSubview(CheckList())
    }

    
}
