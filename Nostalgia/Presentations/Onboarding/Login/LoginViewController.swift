//
//  LoginViewController.swift
//  Nostalgia
//
//  Created by 박효준 on 3/25/24.
//

import UIKit

class LoginViewController: UIViewController {
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
    }
}

extension LoginViewController {
    @objc func didLoginButtonClicked() {
        print("didLoginButtonClicked called()")
        kakaoAuthViewModel.handleKakaoLogin()
    }
    
    @objc func didLogoutButtonClicked() {
        print("didLogoutButtonClicked called()")
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
