//
//  OnboardingViewController.swift
//  Apple Music
//
//  Created by Pavel Koyushev on 02.09.2022.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

final class OnboardingViewController: UIViewController {
    
    private var input: OnboardingViewModelInputProtocol!
    private var output: OnboardingViewModelOutputProtocol!
    private var viewModel: OnboardingViewModelProtocol!
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: .init())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.hidesForSinglePage = true
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var nextButton = BlueButton()
    
    private let disposeBag = DisposeBag()
    
    private let onAppear = PublishRelay<Void>()
    private let nextTap = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onAppear.accept(())
    }
    
    func inject(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension OnboardingViewController {
    
    func setupUI() {
        
        configureUI()
        makeConstraints()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        collectionView.do {
            $0.register(cellType: OnboardingCollectionViewCell.self)
            $0.alwaysBounceVertical = false
            $0.isPagingEnabled = true
            $0.bounces = false
            $0.collectionViewLayout = OnboardingFlowLayout()
            $0.showsHorizontalScrollIndicator = false
            $0.allowsMultipleSelection = false
        }
        
        pageControl.do {
            $0.pageIndicatorTintColor = .gray
            $0.currentPageIndicatorTintColor = .blue
            $0.addTarget(self, action:#selector(pageControlTapHandler(sender:)),
                         for: .valueChanged)
        }
        
        nextButton.do {
            $0.setTitle("Next", for: .normal)
        }
    }
    
    func makeConstraints() {
        
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottomMargin).offset(-100)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(view.snp.bottomMargin).offset(-50)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(nextButton.snp.top).offset(-30)
        }
    }
}

private extension OnboardingViewController {
    
    func bindUI() {
        bindViewModel()
        bindCollectionView()
        bindNextButton()
    }

    func bindViewModel() {

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        let input = OnboardingViewModelInput(nextTap: nextTap.asObservable())

        output = viewModel.transform(input: input)
    }

    func bindCollectionView() {
        
        output.items.drive(collectionView.rx.items(cellIdentifier: OnboardingCollectionViewCell.reuseIdentifier,
                                                   cellType: OnboardingCollectionViewCell.self)) { _, model, cell in
            cell.configureCell(with: model)
        }
        .disposed(by: disposeBag)

        output.items.drive(onNext: { [weak self] items in
            
            guard let self = self else { return }
            self.pageControl.numberOfPages = items.count
        })
        .disposed(by: disposeBag)
    }
    
    func bindNextButton() {
        
        nextButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            var currentPage = self.pageControl.currentPage
            
            if currentPage == self.pageControl.numberOfPages - 1 {
                
                self.nextTap.accept(())
            } else {
                
                currentPage += 1
                self.pageControl.currentPage = currentPage
                
                let indexPath = IndexPath(item: currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.setNextButtonTitle()
            }
        })
        .disposed(by: disposeBag)
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
        setNextButtonTitle()
    }
}

extension OnboardingViewController {
    
    @objc func pageControlTapHandler(sender: UIPageControl) {
        
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        print(sender.currentPage)
        
        setNextButtonTitle()
    }
    
    func setNextButtonTitle() {
        
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            nextButton.setTitle(R.string.localizable.start(), for: .normal)
        } else {
            nextButton.setTitle(R.string.localizable.next(), for: .normal)
        }
    }
}
