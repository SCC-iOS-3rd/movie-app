//
//  UserData.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/22/24.
//

import Foundation

class UserData {
    
    // 기본 이미지 상수
     private let defaultProfileImageName = "defaultImage"
     
     // 싱글톤 인스턴스
     static let shared = UserData()
     
     // 사용자 데이터
     var profileImageName: String?
     var nickname: String?
     var email: String?
     var isLoggedIn: Bool = false
     
     private init() {
         // Singleton pattern을 따라 private으로 초기화
     }
     
     // 사용자 로그인
     func login(profileImageName: String?, nickname: String?, email: String?) {
         self.profileImageName = profileImageName
         self.nickname = nickname
         self.email = email
         isLoggedIn = true
     }
     
     // 사용자 로그아웃
     func logout() {
         self.profileImageName = nil
         self.nickname = nil
         self.email = nil
         isLoggedIn = false
     }
     
     // 프로필 이미지가 설정되어 있지 않은 경우 기본 이미지 반환
     func getProfileImageNameOrDefault() -> String {
         return profileImageName ?? defaultProfileImageName
     }
 }
