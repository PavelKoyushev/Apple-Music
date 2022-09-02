//
//  OnboardingFlow.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import Foundation
import RxFlow

final class OnboardingFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()
    
    init() {
        
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .onboarding:
            return navigationToOnboardingScreen()
        default:
            return .none
        }
    }
    
    private func back() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }
    
    private func navigationToOnboardingScreen() -> FlowContributors {
        
        let viewController = OnboardingViewController()
        let viewModel = OnboardingViewModel()
        
        viewController.inject(viewModel: viewModel)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: viewController,
                                                 withNextStepper: viewModel))
    }
}
