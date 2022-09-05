//
//  CellBuilder.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import Foundation
import Reusable
import RxCocoa

protocol CodeCellConfigurable {
    associatedtype Model
    func configureCell(with model: Model)
}
