//
//  CreatePodcastView.swift
//  vk-podcast
//
//  Created by milkyway on 16.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import SwiftUI

struct CreatePodcastView: View {
    @ObservedObject var podcastPost: PodcastPost
    
    @State var fieldsTitleFilled = false
    @State var fieldsDescriptionFilled = false
    @State var audioAdded = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("backButton").frame(width: 64, alignment: .leading)
        }
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Divider()
                .padding([.leading, .trailing])
            
            ScrollView {
                HStack(spacing: 12) {
                    ZStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("fieldsGray"))
                            Image("landscape")
                        }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.5)
                            .opacity(0.12)
                    }
                    .frame(width: 72, height: 72)
                    
                    InputFieldView(title: "Название",
                                   placeholder: "Введите название подкаста",
                                   w: 267, h: 44,
                                   textFieldInModel: self.podcastPost.title,
                                   updateModel: self.podcastPost.updateTitle,
                                   fieldFilled: $fieldsTitleFilled
                    )
                    
                }
                .frame(width: 351, height: 74)
                .padding(.bottom, 28)
                .padding(.top)
                
                InputFieldView(title: "Описание подкаста",
                               w: 351, h: 64,
                               textFieldInModel: self.podcastPost.description,
                               updateModel: self.podcastPost.updateDescription,
                               fieldFilled: $fieldsDescriptionFilled
                )
                    .padding(.bottom, audioAdded ? 22 : 32)
                
                DownloadFileView(downloaded: $audioAdded, podcastPost: podcastPost)
                    .padding(.bottom, audioAdded ? 22 : 32)
                Divider()
                    .padding([.leading, .trailing])
                
                CheckBoxView(podcastPost: podcastPost).padding(.bottom, 14.5)
                
                AvailibilityView()
            }
            
            Spacer()
            
            VkButtonView(with: "Далее", navTitle: "Новый подкаст", at: CheckView(podcastPost: podcastPost), isActive: fieldsTitleFilled && fieldsDescriptionFilled && audioAdded)
                .animation(.easeInOut(duration: 0.25))
                .frame(width: 351, height: 44)
                
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

struct AvailibilityView: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Кому доступен данный подкаст")
                        .font(.system(size: 17))
                    Text("Всем пользователям")
                    .foregroundColor(Color("sublineTextGray"))
                        .font(.system(size: 11))
                }.padding(.leading, 12)
                Spacer()
                Image("arrowRight").padding(.trailing, 20.41)
            }.frame(width: 375, height: 48).padding(.bottom, 4)
            
            Text("При публикации записи с эпизодом, он становится доступным для всех пользователей")
                .font(.system(size: 13))
                .foregroundColor(Color("sublineTextGray"))
                .frame(width: 351, height: 32, alignment: .leading)
        }
    }
}

struct CheckBoxView: View {
    @ObservedObject var podcastPost: PodcastPost
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Group {
                    if self.podcastPost.explicitContent {
                        Image("ok")
                    } else {
                        RoundedRectangle(cornerRadius: 4)
                        .stroke()
                        .foregroundColor(Color("checkBoxGray"))
                        .frame(width: 20, height: 20)
                    }
                }.transition(.scale)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.15)) {
                        self.podcastPost.switchExplicitContent()
                    }
                }
                Text("Ненормативный контент")
                Spacer()
            }
            .padding(.leading, 14)
            .frame(width: 375, height: 48)
            
            HStack {
                Group {
                    if self.podcastPost.excludeFromExport {
                        Image("ok")
                    } else {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke()
                            .foregroundColor(Color("checkBoxGray"))
                            .frame(width: 20, height: 20)
                    }
                }.transition(.scale)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.15)) {
                        self.podcastPost.switchExcludeFromExport()
                    }
                }
                Text("Исключить эпизод из экспорта")
                Spacer()
            }
            .padding(.leading, 14)
            .frame(width: 375, height: 48)
            
            HStack {
                Group {
                    if self.podcastPost.podcastTrailer {
                        Image("ok")
                    } else {
                        RoundedRectangle(cornerRadius: 4)
                        .stroke()
                        .foregroundColor(Color("checkBoxGray"))
                        .frame(width: 20, height: 20)
                    }
                }.transition(.scale)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.15)) {
                        self.podcastPost.switchPodcastTrailer()
                    }
                }
                Text("Трейлер подкаста")
                Spacer()
            }
            .padding(.leading, 14)
            .frame(width: 375, height: 48)
        }
    }
}

struct DownloadFileView: View {
    @Binding var downloaded: Bool
    @ObservedObject var podcastPost: PodcastPost
    
    var body: some View {
        VStack(spacing: .zero) {
            if downloaded {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("fieldsGray"))
                            .frame(width: 48, height: 48)
                        Image("mic")
                    }
                    Text("My_podcast.mp3")
                        .font(.system(size: 18))
                    Spacer()
                    Text("59:16")
                    .font(.system(size: 13))
                    .foregroundColor(Color("timeGray"))
                }
                    .padding([.trailing, .leading], 12)
                    .padding(.bottom, 10)
                
                Text("Вы можете добавить таймкоды и скорректировать подкаст в режиме редактирования")
                    .font(.system(size: 13))
                    .foregroundColor(Color("sublineTextGray"))
                    .frame(width: 351, height: 32, alignment: .leading)
                    .padding(.bottom, 18)
                
                ZStack {
                    NavigationLink(destination: EditorView(podcastPost: podcastPost)
                        .navigationBarTitle("Редактирование")) {
                        RoundedRectangle(cornerRadius: 10)
                        .stroke()
                    }
                    
                    Text("Редактировать аудиозапись").font(.system(size: 17, weight: .medium))
                        
                }
                    .foregroundColor(Color("buttonLightBlue"))
                    .frame(width: 351, height: 44)
                
            } else {
                Text("Загрузите Ваш подкаст")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 8)
                Text("Выберите готовый аудиофайл из вашего телефона и добавьте его")
                    .font(.system(size: 16))
                .foregroundColor(Color("sublineTextGray"))
                    .multilineTextAlignment(.center)
                    .frame(width: 311, height: 40)
                    .padding(.bottom, 24)
                
                Button(action: {
                    withAnimation {
                        self.downloaded = true
                    }
                    
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                        Text("Загрузить файл").font(.system(size: 15, weight: .medium))
                            
                    }
                        .foregroundColor(Color("buttonLightBlue"))
                        .frame(width: 148, height: 36)
                }
            }
        }
    }
}



struct InputFieldView: View {
    var title: String
    var placeholder: String?
    var w: CGFloat?
    var h: CGFloat?
    
    var textFieldInModel: String?
    
    var updateModel: (String) -> Void
    
    @State var desc = ""
    @Binding var fieldFilled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .foregroundColor(Color("titleGray"))
                .font(.system(size: 14))
            
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("fieldsGray"))
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.5)
                    .opacity(0.12)
                }
                
                HStack {
                    TextField(placeholder ?? "", text: $desc, onEditingChanged: { began in
                        if !began {
                            self.updateModel(self.desc)
                            self.fieldFilled = self.desc.count > 0
                        }
                    })
//                    Text(placeholder ?? "")
//                        .frame(height: h)
                        .padding(.leading, 12)
                        .font(.system(size: 14))
        
                    Spacer()
                }.frame(height: h)
            }
            .onAppear {
                self.desc = self.textFieldInModel ?? ""
            }
            .frame(width: w, height: h)
        }
        
    }
}

struct CreatePodcastView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePodcastView(podcastPost: PodcastPost())
    }
}
