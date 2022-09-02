//
//  OnboardingViewModel.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

struct OnboardingViewModelInput: OnboardingViewModelInputProtocol {
    
    let onAppear: Observable<Void>
    let startTap: Observable<Void>
}

struct OnboardingViewModelOutput: OnboardingViewModelOutputProtocol {
    
}

final class OnboardingViewModel: Stepper {
    
    var steps = PublishRelay<Step>()
    
}

extension OnboardingViewModel: OnboardingViewModelProtocol {
    
    func transform(input: OnboardingViewModelInputProtocol) -> OnboardingViewModelOutputProtocol {
        
        let output = OnboardingViewModelOutput()
        return output
    }
}
