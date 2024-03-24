//
//  OnboardingViewController.swift
//  Nostalgia
//
//  Created by 박효준 on 3/24/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.spacing = 20
        
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let titleText: UILabel = {
        let titleText = UILabel()
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.textAlignment = .center
        titleText.numberOfLines = 0
        titleText.font = UIFont.preferredFont(forTextStyle: .title3)
        titleText.adjustsFontForContentSizeCategory = true
        
        return titleText
    }()
    
    // 프로퍼티 클로저 초기화 -> init() 호출, 문제없음
    init(firstImageViewName: String, titleText: String) {
        self.imageView.image = UIImage(systemName: firstImageViewName)
        self.titleText.text = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OnboardingViewController - viewDidLoad() called")
        self.view.backgroundColor = .gray
        
        setup()
    }
    
    private func setup() {
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(titleText)
        stackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
