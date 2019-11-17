//
//  ViewController2.swift
//  GretasApp
//
//  Created by Evgeniya Tveritinova on 16/11/2019.
//  Copyright © 2019 Daria Zvereva. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    @IBOutlet weak var mainStackView: UIStackView!
    
    var checkListStackView: UIStackView!
    var challengesStackView: UIStackView!

    var viewByTag: [Int: UIView] = [:]
    var currentTag: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
            
        let title = UILabel()
        title.text = "Track your habbits"
        title.font = UIFont(name: "Helvetica-Bold", size: 24)
        title.textColor = UIColor(red: 231 / 255, green: 123 / 255, blue: 45 / 255, alpha: 1.0)
        
        mainStackView.addArrangedSubview(title)
        
        checkListStackView = UIStackView()
        checkListStackView.axis = .vertical
        checkListStackView.alignment = .fill
        checkListStackView.distribution = .equalSpacing
        checkListStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let allChecks = ["12345", "123245323", "gsdfgsdfgsf", "sfgsfg", "sgsagdf", "fsfgdsfg"]

        // read
        let historyChecks = [("2019-11-03T11:00:00+0000", "12345"), ("2019-11-15T11:00:00+0000", "12345")]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX

        let filter = historyChecks.filter({ (date, check) -> Bool in
           if Calendar.current.isDateInToday(dateFormatter.date(from: date)!) {
               return true
           } else {
               return false
           }
        }).map { (date, check) -> String in
           return check
        }
        
        for check in allChecks {
            if filter.contains(where: { (c) -> Bool in
                if c == check {
                    return true
                } else {
                    return false
                }
            }) {
                continue
            }
            let bView = createView(l: check, withAction: true, done: true)
            checkListStackView.addArrangedSubview(bView)
        }
        
        
        mainStackView.addArrangedSubview(checkListStackView)

//        addIfEmpty()
        
        
        
        // COUNTERS
        
        let counterBackground = UIView()
        counterBackground.backgroundColor = hexStringToUIColor(hex: "123C69")
        counterBackground.heightAnchor.constraint(equalToConstant: 125).isActive = true
        mainStackView.addArrangedSubview(counterBackground)
        
        let counter1 = UILabel()
        counterBackground.addSubview(counter1)
        counter1.translatesAutoresizingMaskIntoConstraints = false
        counter1.text = "Days without using disposable cups"
        counter1.font = UIFont(name: "Helvetica-Bold", size: 16)
        counter1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        counter1.widthAnchor.constraint(equalToConstant: 220).isActive = true
        counter1.textColor = .white
        counter1.topAnchor.constraint(equalTo: counterBackground.topAnchor, constant: 15).isActive = true
        counter1.leftAnchor.constraint(equalTo: counterBackground.leftAnchor, constant: 15).isActive = true
        counter1.numberOfLines = 2
        
        let counterValueView = UIView()
        counterBackground.addSubview(counterValueView)
        counterValueView.translatesAutoresizingMaskIntoConstraints = false
        counterValueView.backgroundColor = .white
        counterValueView.layer.cornerRadius = 5
        counterValueView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        counterValueView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        counterValueView.topAnchor.constraint(equalTo: counterBackground.topAnchor, constant: 15).isActive = true
        counterValueView.rightAnchor.constraint(equalTo: counterBackground.rightAnchor, constant: -15).isActive = true
        
        let counterValue = UILabel()
        counterValueView.addSubview(counterValue)
        counterValue.translatesAutoresizingMaskIntoConstraints = false
        counterValue.font = UIFont(name: "Helvetica-Bold", size: 20)
        counterValue.text = "3"
        counterValue.textAlignment = .center
        counterValue.textColor = .black
        counterValue.widthAnchor.constraint(equalToConstant: 40).isActive = true
        counterValue.heightAnchor.constraint(equalToConstant: 30).isActive = true
        counterValue.topAnchor.constraint(equalTo: counterValueView.topAnchor, constant: 5).isActive = true
        counterValue.rightAnchor.constraint(equalTo: counterValueView.rightAnchor, constant: -5).isActive = true
    
        
        let counter2 = UILabel()
        counterBackground.addSubview(counter2)
        counter2.translatesAutoresizingMaskIntoConstraints = false
        counter2.text = "Overconsumped food"
        counter2.font = UIFont(name: "Helvetica-Bold", size: 16)
        counter2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        counter2.widthAnchor.constraint(equalToConstant: 220).isActive = true
        counter2.textColor = .white
        counter2.topAnchor.constraint(equalTo: counter1.bottomAnchor, constant: 15).isActive = true
        counter2.leftAnchor.constraint(equalTo: counterBackground.leftAnchor, constant: 15).isActive = true
        
        let counterValueView2 = UIView()
        counterBackground.addSubview(counterValueView2)
        counterValueView2.translatesAutoresizingMaskIntoConstraints = false
        counterValueView2.backgroundColor = .white
        counterValueView2.layer.cornerRadius = 5
        counterValueView2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        counterValueView2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        counterValueView2.topAnchor.constraint(equalTo: counter1.bottomAnchor, constant: 15).isActive = true
        counterValueView2.rightAnchor.constraint(equalTo: counterBackground.rightAnchor, constant: -15).isActive = true
        
        let counterValue2 = UILabel()
        counterValueView2.addSubview(counterValue2)
        counterValue2.translatesAutoresizingMaskIntoConstraints = false
        counterValue2.font = UIFont(name: "Helvetica-Bold", size: 15)
        counterValue2.text = "1 kg"
        counterValue2.textAlignment = .center
        counterValue2.textColor = .black
        counterValue2.widthAnchor.constraint(equalToConstant: 40).isActive = true
        counterValue2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        counterValue2.topAnchor.constraint(equalTo: counterValueView2.topAnchor, constant: 5).isActive = true
        counterValue2.rightAnchor.constraint(equalTo: counterValueView2.rightAnchor, constant: -5).isActive = true
        
        
        let title1 = UILabel()
        title1.text = "Challenges"
        title1.font = UIFont(name: "Helvetica-Bold", size: 24)
        title1.textColor = UIColor(red: 231 / 255, green: 123 / 255, blue: 45 / 255, alpha: 1.0)
        mainStackView.addArrangedSubview(title1)
        
        
        challengesStackView = UIStackView()
        challengesStackView.axis = .vertical
        challengesStackView.alignment = .fill
        challengesStackView.distribution = .equalSpacing
        challengesStackView.translatesAutoresizingMaskIntoConstraints = false

        mainStackView.addArrangedSubview(challengesStackView)

        let allChallenges = ["challenge 1", "challenge 2", "challenge 3"]
        let doneChallenges = ["challenge 2"]

        for challenge in allChallenges {
            print(challenge)
            var done = false
            if doneChallenges.contains(where: { (c) -> Bool in
                if c == challenge {
                    return true
                } else {
                    return false
                }
            }) {
                done = true
            }

            let view_ = createView(l: challenge, withAction: false, done: done)
            challengesStackView.addArrangedSubview(view_)
        }
    }
    
    @objc
    func handleTouch(sender: UIButton) {
        // write to history
        checkListStackView.removeArrangedSubview(viewByTag[sender.tag]!)
        viewByTag[sender.tag]!.removeFromSuperview()

        addIfEmpty()
    }

    func addIfEmpty() {
        print(checkListStackView.subviews.count)
        if checkListStackView.subviews.count == 0 {
            let label = UILabel()
            label.text = "All done!\n"
            label.textColor = .gray
            label.font = UIFont(name: "Helvetica", size: 20.0)
            label.translatesAutoresizingMaskIntoConstraints = false

            checkListStackView.addSubview(label)
            checkListStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }

    func createView(l: String, withAction: Bool, done: Bool) -> UIView {
        print("create")
        let background = UIView()
        background.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        background.backgroundColor = hexStringToUIColor(hex: "F0F0F0")

        background.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton()

        background.addSubview(button)

        button.topAnchor.constraint(equalTo: background.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10).isActive = true
        button.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        

        let label = UILabel()
        background.addSubview(label)

        label.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: background.topAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10).isActive = true
        label.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -10).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = l
        
        
        if withAction {
            button.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
            button.tag = currentTag
            viewByTag[currentTag] = background
            currentTag += 1
            button.setTitle("🔘", for: .normal)
        } else {
            if done {
                button.setTitle("⭐️", for: .normal)
                label.font = UIFont(name: "Helevtica-Bold", size: 16.0)
//                button.setImage(UIImage(named: "star"), for: .normal)
            } else {
                button.setTitle("🔘", for: .normal)
                label.font = UIFont(name: "Helevtica-Light", size: 16.0)
            }
        }

        return background
    }

}
