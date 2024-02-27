//
//  LoginViewModel.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/26.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var userEmail = ""
    @Published var userPhoneNumber = ""
    @Published var userPassword = ""
    @Published var userRepeatedPassword = ""
    
    private var publishers = Set<AnyCancellable>()
    
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let phoneRegex = "^01[0-1, 7][0-9]{7,8}"
    
    // Output subscribers
    @Published var formIsValid = false
    init() {
        //퍼블리셔 구독
        isSignupFormValidPublisher
            .receive(on: RunLoop.main) //UI업데이트기 때문에 메인스레드
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
    }
    //메모리 관리를 위한 구독 취소
    deinit {
        publishers.forEach { $0.cancel() }
     }
    

}


private extension LoginViewModel {
    

    // MARK: - 유저 이메일 + 폰번호

    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
          $userEmail
              .map { email in
                  let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "\(self.emailRegex)|\(self.phoneRegex)")
                  return emailPredicate.evaluate(with: email) //정규식 평가 결과
              }
              .eraseToAnyPublisher()
      }
    
    // MARK: - 비밀번호

      var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
          //8자리 ~ 50자리 영어 + 숫자 + 특수문자
          $userPassword
              .map { password in
                  let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}")
                  return passwordPredicate.evaluate(with: password) //정규식 평가 결과
              }
              .eraseToAnyPublisher()
      }
    // MARK: - 통합

    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
          Publishers.CombineLatest(
              isUserEmailValidPublisher,
              isPasswordValidPublisher
              )
              .map { isEmailValid,isPasswordValid in
                  return (isEmailValid  && isPasswordValid) //이메일 && 비밀번호
              }
              .eraseToAnyPublisher()
      }
}




extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                withAnimation {
                    return notification.keyboardHeight
                }
            }
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
