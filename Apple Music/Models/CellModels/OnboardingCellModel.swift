//
//  OnboardingCellModel.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import Foundation
import RxCocoa

struct OnboardingModel {
    
    let title: String
    let image: UIImage
}

protocol OnboardingCellModelProtocol {
    
    var item: OnboardingModel { get }
}

struct OnboardingCellModel: OnboardingCellModelProtocol {
    
    let item: OnboardingModel
}
