//
//  OnboardingViewController.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    
    private var input: OnboardingViewModelInputProtocol!
    private var output: OnboardingViewModelOutputProtocol!
    private var viewModel: OnboardingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }
    
    func inject(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
    }
}
