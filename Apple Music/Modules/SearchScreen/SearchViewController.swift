//
//  SearchViewController.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 04.09.2022.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController, Stepper  {
    
    var steps = PublishRelay<Step>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }
}
