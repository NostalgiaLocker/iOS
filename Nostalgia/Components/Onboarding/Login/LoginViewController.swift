//
//  LoginViewController.swift
//  Nostalgia
//
//  Created by 박효준 on 3/25/24.
//

import UIKit

class LoginViewController: UIViewController {

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.text = "\(Bundle.main.object(forInfoDictionaryKey: "KAKAO_API_KEY") as? String ?? "") qwe"
        
        return titleLabel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginViewController - viewDidLoad() called")
        
        view.backgroundColor = .orange
        setup()
    }
    
    private func setup() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
