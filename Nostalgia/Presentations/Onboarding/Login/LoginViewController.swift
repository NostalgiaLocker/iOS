//
//  LoginViewController.swift
//  Nostalgia
//
//  Created by 박효준 on 3/25/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.text = "\(Bundle.main.object(forInfoDictionaryKey: "KAKAO_API_KEY") as? String ?? "") qwe"
        
        return titleLabel
    }()
    
    lazy var kakaoLoginStatusLabel: UILabel = {
        let kakaoLoginStatusLabel = UILabel()
        kakaoLoginStatusLabel.text = "로그인 여부 라벨"
        kakaoLoginStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return kakaoLoginStatusLabel
    }()
    
    lazy var kakaoLoginButton: UIButton = {
        let kakaoLoginButton = UIButton(type: .system)
        kakaoLoginButton.setTitle("카카오 로그인", for: .normal)
        kakaoLoginButton.configuration = .filled()
        kakaoLoginButton.translatesAutoresizingMaskIntoConstraints = false
        kakaoLoginButton.addTarget(self, action: #selector(didLoginButtonClicked), for: .touchUpInside)
        
        return kakaoLoginButton
    }()
    
    lazy var kakaoLogoutButton: UIButton = {
        let kakaoLogoutButton = UIButton(type: .system)
        kakaoLogoutButton.setTitle("카카오 로그아웃", for: .normal)
        kakaoLogoutButton.configuration = .filled()
        kakaoLogoutButton.translatesAutoresizingMaskIntoConstraints = false
        kakaoLogoutButton.addTarget(self, action: #selector(didLogoutButtonClicked), for: .touchUpInside)
        
        return kakaoLogoutButton
    }()
    
    lazy var kakaoAuthViewModel: KakaoAuthViewModel = { KakaoAuthViewModel() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginViewController - viewDidLoad() called")
        view.backgroundColor = .orange
        
        setup()
        setupSheetPresentation()
        setBindings()
    }
}

extension LoginViewController {
    @objc func didLoginButtonClicked() {
        print("didLoginButtonClicked called()")
        kakaoAuthViewModel.handleKakaoLogin()
    }
    
    @objc func didLogoutButtonClicked() {
        print("didLogoutButtonClicked called()")
        kakaoAuthViewModel.handleKakaoLogout()
    }
    
    private func setup() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(kakaoLoginStatusLabel)
        stackView.addArrangedSubview(kakaoLoginButton)
        stackView.addArrangedSubview(kakaoLogoutButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupSheetPresentation() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.large()]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = 25
        }
    }
}

// MARK: 뷰모델 바인딩
extension LoginViewController {
    fileprivate func setBindings() {
//        self.kakaoAuthViewModel.$isLoggedInt.sink { [weak self] isLogged in // Published
//            guard let self = self else { return } // 순환참조 예방
//            self.titleLabel.text = isLogged ? "로그인 상태" : "로그아웃 상태"
//        }.store(in: &subscriptions)
        
        self.kakaoAuthViewModel.loginStatusInfo
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.kakaoLoginStatusLabel)
            .store(in: &subscriptions)
    }
}
