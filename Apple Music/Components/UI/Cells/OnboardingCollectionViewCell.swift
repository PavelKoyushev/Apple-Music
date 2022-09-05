//
//  OnboardingCollectionViewCell.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import UIKit
import Then
import Reusable
import RxSwift
import RxCocoa

final class OnboardingCollectionViewCell: UICollectionViewCell, CodeCellConfigurable, Reusable {
    
    private var disposeBag = DisposeBag()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configureCell(with model: OnboardingCellModelProtocol) {
        imageView.image = model.item.image
        titleLabel.text = model.item.title
    }
}

extension OnboardingCollectionViewCell {
    
    func setupLayout() {
        
        configureUI()
        makeConstraints()
    }
    
    func configureUI() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
            $0.contentMode = .scaleAspectFill
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 24, weight: .heavy)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.tintColor = .black
        }
    }
    
    func makeConstraints() {
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }
}
