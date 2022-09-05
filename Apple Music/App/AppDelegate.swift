//
//  AppDelegate.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import UIKit
import SnapKit
import RxFlow
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var appFlow: AppFlow!
    let coordinator = FlowCoordinator()
    
    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard let window = window else { return false }
        
        appFlow = AppFlow(withWindow: window)
        
        coordinator.rx.didNavigate
            .subscribe(onNext: { flow, step in
                print("did navigate to flow=\(flow) and step=\(step)")
            }).disposed(by: disposeBag)
        
        self.coordinator.coordinate(flow: appFlow, with: AppStepper())
        
        return true
    }
}
