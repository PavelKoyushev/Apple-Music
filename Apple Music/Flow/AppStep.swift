//
//  AppStep.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case onboarding
    case onboardingIsComplete
    case dashboard
    case search
}
