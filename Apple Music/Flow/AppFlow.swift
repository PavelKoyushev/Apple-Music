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
        case .onboardingIsComplete:
            return navigateToDashboardFlow()
        default:
            return FlowContributors.none
        }
    }
    
    private func navigationToOnboardingScreen() -> FlowContributors {
        let onboardingFlow = OnboardingFlow()
        
        Flows.use(onboardingFlow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: onboardingFlow,
                                                                withNextStepper: OneStepper(withSingleStep: AppStep.onboarding)))
    }
    
    private func navigateToDashboardFlow() -> FlowContributors {
        let dashboard = DashboardFlow()
        
        Flows.use(dashboard, when: .ready) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }

        return .one(flowContributor: .contribute(withNextPresentable: dashboard,
                                                 withNextStepper: OneStepper(withSingleStep: AppStep.dashboard)))
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
