//
//  SearchFlow.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 04.09.2022.
//

import RxFlow

final class SearchFlow: Flow {
    
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
        case .search:
            return searchScreen()
        default:
            return .none
        }
    }
    
    private func searchScreen() -> FlowContributors {
        
        let viewController = SearchViewController()
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: .contribute(withNext: viewController))
    }
}
