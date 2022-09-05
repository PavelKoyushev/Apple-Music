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
    
    let nextTap: Observable<Void>
}

struct OnboardingViewModelOutput: OnboardingViewModelOutputProtocol {
    
    let items: Driver<[OnboardingCellModel]>
}

final class OnboardingViewModel: Stepper {
    
    let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
}

extension OnboardingViewModel: OnboardingViewModelProtocol {
    
    func transform(input: OnboardingViewModelInputProtocol) -> OnboardingViewModelOutputProtocol {
        
        let models = [OnboardingCellModel(item: OnboardingModel(title: R.string.localizable.appleMusic(),
                                                                image: R.image.amusic1()!)),
                      OnboardingCellModel(item: OnboardingModel(title: R.string.localizable.seaOfMusic(),
                                                                image: R.image.amusic2()!)),
                      OnboardingCellModel(item: OnboardingModel(title: R.string.localizable.findSongs(),
                                                                image: R.image.amusic3()!))]
        
        let items = BehaviorRelay<[OnboardingCellModel]>(value: models)
        
        input.nextTap
            .map { AppStep.dashboard }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        let output = OnboardingViewModelOutput(items: items.asDriver(onErrorDriveWith: .never()))
        
        return output
    }
}
