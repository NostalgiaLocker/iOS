//
//  SplashViewController.swift
//  Nostalgia
//
//  Created by 박효준 on 3/24/24.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SplashViewController - viewDidLoad() called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lottieAnimationView.play { _ in
            var loadViewController: UIViewController
            if UserDefaults.standard.bool(forKey: "didHomeView") == true {
                let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
                loadViewController = homeStoryBoard.instantiateInitialViewController() as! HomeViewController
            }else {
                loadViewController = OnboardingViewController(nibName: nil, bundle: nil)
            }
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: {$0.isKeyWindow}) {
                window.rootViewController = loadViewController
            }
        }
    }
}
