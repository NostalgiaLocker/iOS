//
//  OnboardingContainerViewController.swift
//  Nostalgia
//
//  Created by 박효준 on 3/24/24.
//

import UIKit

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentViewController: UIViewController
    let pageControl = UIPageControl()
    let closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("시작하기", for: .normal)
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 15
        
        return closeButton
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(firstImageViewName: "heart", titleText: "온보딩 1페이지")
        let page2 = OnboardingViewController(firstImageViewName: "bubble", titleText: "온보딩 2페이지")
        let page3 = OnboardingViewController(firstImageViewName: "person", titleText: "온보딩 3페이지")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentViewController = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OnboardingContainerViewController - viewDidLoad() called")
        
        self.view.backgroundColor = .gray
        setupPages()
        setupComponents()
    }
}

extension OnboardingContainerViewController {
    @objc func didCloseTapped(_ sender: UIButton) {
        let loginViewController = LoginViewController()
        
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    private func setupPages() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentViewController = pages.first!
    }
    
    private func setupComponents() {
        closeButton.addTarget(self, action: #selector(didCloseTapped), for: .primaryActionTriggered)
        view.addSubview(closeButton)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 250),
            closeButton.heightAnchor.constraint(equalToConstant: 55),
            
            pageControl.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentViewController = pages[index - 1]
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentViewController = pages[index + 1]
        return pages[index + 1]
    }
}

// 페이지 전환 시 페이지 컨트롤의 현재 페이지 업데이트
extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: visibleViewController) {
            pageControl.currentPage = index
        }
    }
}
