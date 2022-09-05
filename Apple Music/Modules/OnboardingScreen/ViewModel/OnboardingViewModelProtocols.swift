//
//  OnboardingViewModelProtocols.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol OnboardingViewModelInputProtocol {
    
    var nextTap: Observable<Void> { get }
}

protocol OnboardingViewModelOutputProtocol {
    
    var items: Driver<[OnboardingCellModel]> { get }
}

protocol OnboardingViewModelProtocol {
    
    func transform(input: OnboardingViewModelInputProtocol) -> OnboardingViewModelOutputProtocol
}
