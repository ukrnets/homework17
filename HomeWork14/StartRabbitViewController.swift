//
//  StartViewController.swift
//  HomeWork14
//
//  Created by Darya Grabowskaya on 12.10.22.
//

import UIKit

class StartRabbitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carrotView.makeShadow()
    }
     
    @IBOutlet weak var carrotView: LogoView!
    
}
