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
    
    var onAppear: Observable<Void> { get }
    var startTap: Observable<Void> { get }
}

protocol OnboardingViewModelOutputProtocol {
    
}

protocol OnboardingViewModelProtocol {
    
    func transform(input: OnboardingViewModelInputProtocol) -> OnboardingViewModelOutputProtocol
}
