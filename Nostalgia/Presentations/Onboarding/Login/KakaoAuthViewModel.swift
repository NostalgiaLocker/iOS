//
//  KakaoAuthViewModel.swift
//  Nostalgia
//
//  Created by 박효준 on 3/25/24.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    @Published var isLoggedIn: Bool = false
    lazy var loginStatusInfo: AnyPublisher<String?, Never> = $isLoggedIn.compactMap{ $0 ? "로그인 상태" : "로그아웃 상태" }.eraseToAnyPublisher() // isLoggedIn에 따라 바뀜, compactMap = nil 들어오면 통과 X
    
    init() {
        print("KakaoAuthViewModel init()")
    }
    
    // MARK: 카카오 로그인
    // 카카오톡 앱으로 로그인 인증
    func kakaoLoginWithApp() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    // 카톡이 설치되어 있지 않은 경우 (카카오 계정으로 로그인)
    func kakaoLoginWithAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    
    // MainActor로 메인 스레드에서 작동함 isLoggedIn은 Published로 UI를 건드릴 거니까
    @MainActor
    func handleKakaoLogin() {
        print("KakaoAuthViewModel - handleKakaoLogin() called")
        Task{
            // 카카오톡 실행 가능 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오톡 앱으로 로그인
                isLoggedIn = await kakaoLoginWithApp()
            } else{
                // 카카오 계정으로 로그인
                isLoggedIn = await kakaoLoginWithAccount()
            }
        }
    } // Login
    
    // MARK: 카카오 로그아웃
    
    func kakaoLogout() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    func handleKakaoLogout() {
        Task {
            if await kakaoLogout() {
                self.isLoggedIn = false
            }
        }
    }
}
