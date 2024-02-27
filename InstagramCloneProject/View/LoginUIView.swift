//
//  TestSwiftUIView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/26.
//

import SwiftUI


  
struct LoginUIView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var keyboardHeight: CGFloat = 0
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()

    @FocusState private var focusedField: Field?
    
    enum Field {
        case emailAddress
        case password
    }
    
    // MARK: - 커스텀 back버튼
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(Color("backColor"))
                Text("")
            }
        }
    }
    
    var body: some View {
        ZStack{
            // MARK: - 키보드 숨김 처리
            VStack() {
                Color(.systemBackground)
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
            VStack(alignment: .center) {
                GeometryReader() { geometry in
                    VStack() {
                        Spacer()
                        // MARK: - 언어 라벨
                        Label("한국어 (대한민국)", systemImage: "")
                            .font(.custom("NotoSansKR-Thin_Regular", size: CGFloat(14)))
                        Spacer()
                        Spacer()
                        // MARK: - 이미지: 다크모드에 따라 교체
                        colorScheme == .dark ? Image("instagramLogoBlack") : Image("instagramLogoWhite")
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(.keyboard, edges: .top)
                    
                }
                Spacer()
                //        .frame(height: 200)
                GeometryReader(content: { geometry in
                    VStack(spacing: 20) {
                        Spacer()
                        // MARK: - 이메일주소 또는 전화번호
                        TextField("전화번호, 이메일", text: $viewModel.userEmail).extensionTextFieldView(roundedCornes: 10, hexString: "D9D9D9",colorScheme: self.colorScheme)
                            //첫화면 키보드 띄우기
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                                    self.focusedField = Field.emailAddress
                                }
                            }
                            //양방향 업데이트..
                            .focused($focusedField, equals: .emailAddress)
                            //엔터치면 다음 포커싱 전환
                            .onSubmit {
                                switch focusedField {
                                case .emailAddress:
                                    //포커싱 필드 패스워드로
                                    focusedField = .password
                                default:
                                    print("login…")
                                }
                            }
                            .keyboardType(.emailAddress)
                       

                        // MARK: - 비밀번호
                        SecureField("password", text: $viewModel.userPassword)            .padding()
                            .background(Color(UIColor(hexString: colorScheme == .dark ? "262626": "DFDFDF")))
                            .cornerRadius(10)
                            .foregroundColor(colorScheme == .dark ? Color(UIColor(hexString: "DFDFDF")) : .black)
                            .focused($focusedField, equals: .password)
//                            .onTapGesture {
//                                self.isEditing = true
//                            }
                        
                        // MARK: - 로그인 버튼
                        NavigationLink(destination: NextView()) {
                                            Text("로그인")
                        }.frame(maxWidth: .infinity)
                        .padding()
                        //정규식 체크
                        .background(viewModel.formIsValid ? Color(UIColor(hexString: "00A3FF")) : Color(UIColor(hexString: "00A3FF")).opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(!viewModel.formIsValid)
                        
                        // MARK: - 로그인 버튼 하단 텍스트

                        FontHelper.shared.customFontText(text: "로그인 정보를 잊으셨나요?",boldText: "들어가는 데 도움을 받으세요", fontSize: 10)
                        Spacer()
                        
                    }.padding(.all)
                    
                })
                Spacer()
                // MARK: - 밑줄이랑 계정 등록 버튼..

                VStack {
                    Spacer()
                    Divider()
                    //나중에 네비게이션 링크로 바꿔야함
                    Button(action:{}){
                        Label {
                            Text("계정이 없나요? ")
                                .font(.custom("NotoSansKR-Thin_Regular", size: CGFloat(12)))
                            Text("등록하세요.").bold()
                                .font(.custom("NotoSansKR-Thin_Regular", size: CGFloat(12)))
                        } 
                        icon: { }
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                .ignoresSafeArea(.keyboard)
            }
        }
        //.navigationTitle("한국어(대한민국)")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }

}




#Preview {
    LoginUIView()
}

