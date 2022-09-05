//
//  DashboardFlow.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 04.09.2022.
//

import UIKit
import RxFlow
import RxCocoa

final class DashboardFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    let rootViewController: UITabBarController = {
        let viewController = UITabBarController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        return viewController
    }()
    
    private let searchFlow: SearchFlow
    
    init() {
        self.searchFlow = SearchFlow()
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .dashboard:
            return navigateToDashboard()
        default:
            return .none
        }
    }
    
    private func navigateToDashboard() -> FlowContributors {
        
        Flows.use(searchFlow, when: .ready) { [unowned self] (root: UINavigationController) in
            
            let tabBarItem = UITabBarItem(title: "Search",
                                          image: UIImage(systemName: "magnifyingglass"),
                                          selectedImage: UIImage(systemName: "magnifyingglass"))
            root.tabBarItem = tabBarItem
            
            rootViewController.setViewControllers([root], animated: true)
        }
        
        return .multiple(flowContributors: [FlowContributor.contribute(withNextPresentable: searchFlow,
                                                                       withNextStepper: OneStepper(withSingleStep: AppStep.search))])
    }
}
