//
//  AppFlow.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift

final class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    
    init(withWindow window: UIWindow) {
        self.rootWindow = window
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return FlowContributors.none }
        
        switch step {
        case .onboarding:
            return navigationToOnboardingScreen()
        default:
            return FlowContributors.none
        }
    }
    
    private func navigationToOnboardingScreen() -> FlowContributors {
        let onboardingFlow = OnboardingFlow()
        
        Flows.use(onboardingFlow, when: .created) { root in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: onboardingFlow, withNextStepper: OneStepper(withSingleStep: AppStep.onboarding)))
    }
}

final class AppStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    var initialStep: Step {
        return AppStep.onboarding
    }

    func readyToEmitSteps() {

    }
}
