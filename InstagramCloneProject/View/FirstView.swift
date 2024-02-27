//
//  FirstView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/27.
//

import SwiftUI

struct FirstView: View {
    @State private var isToggled = false
    
    var body: some View {
        
      NavigationView {
        VStack {
            VStack {
                VStack {
                    Toggle("다크모드", isOn: $isToggled)
                        .padding()
                        .onChange(of: isToggled) { newValue in
                            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                            windowScene?.windows.first?.rootViewController?.overrideUserInterfaceStyle = newValue ? .dark : .light
                        }
                        .frame(width: 150)
                }.frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            VStack {
                NavigationLink(destination: LoginUIView()) {
                    Text("다른 아이디로 로그인")
                }.frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color(UIColor(hexString: "00A3FF")))
                .cornerRadius(10)
                .padding()
                Spacer()
            }       
            .frame(maxWidth: .infinity)
        }
      }
    }
}

#Preview {
    FirstView()
}
