//
//  ViewController1.swift
//  GretasApp
//
//  Created by Evgeniya Tveritinova on 16/11/2019.
//  Copyright © 2019 Daria Zvereva. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = do_sync()
        // Do any additional setup after loading the view.
    }
    
    func do_sync() -> String {
        let http_client = HttpClient(_baseUrl: "https://kesko.azure-api.net/", _token: "cd16ea05859948a5be469dafdf0a2a40")
        let (data, response, error) = http_client.getProductByShopAndCode(shopCode: "N106", productCode: "2000686300003")
        
        return String(data: data!, encoding: .utf8)!
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
