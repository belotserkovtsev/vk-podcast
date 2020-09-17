//
//  CheckView.swift
//  vk-podcast
//
//  Created by milkyway on 17.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import SwiftUI

struct CheckView: View {
    @ObservedObject var podcastPost: PodcastPost
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("backButton").frame(width: 64, alignment: .leading)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.bottom, 13.5)
                .padding([.leading, .trailing])
            
            HStack {
                ZStack {
                    Image("dog")
                    .frame(width: 72, height: 72)
                    Image("play")
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text(podcastPost.title!)
                        .font(.system(size: 17, weight: .semibold))
                    Text("ПараDogs").foregroundColor(Color("buttonBlue"))
                        .font(.system(size: 12, weight: .medium))
                    Text("Длительность: 59:16").foregroundColor(Color("sublineTextGray"))
                        .font(.system(size: 12))
                }
                Spacer()
            }.frame(width: 351, height: 74).padding([.leading, .bottom], 12)
            Divider()
                .padding(.bottom, 13.5)
                .padding([.leading, .trailing])
            
            HStack {
                Text("Описание").font(.system(size: 17, weight: .semibold))
                Spacer()
            }
                .padding(.leading, 12)
                .padding(.bottom, 13)
            
            HStack {
                Text(podcastPost.description!).font(.system(size: 15))
                Spacer()
            }
                .padding(.leading, 12)
                .padding(.bottom, 18)
            
            Divider().padding([.leading, .trailing]).padding(.bottom, 9)
            
            if podcastPost.timeCodes.count > 0 {
                HStack {
                    Text("Содержание").font(.system(size: 17, weight: .semibold))
                    Spacer()
                }
                    .padding(.leading, 12)
                    .padding(.bottom, 13)
                 
                 ScrollView {
                     VStack(spacing: .zero) {
                         //14+14
                         ForEach(podcastPost.timeCodes) { item in
                             HStack {
                                 Text(item.time!).foregroundColor(Color("buttonBlue"))
                                 Text("—")
                                 Text(item.title!)
                                 Spacer()
                             }
                             .padding(.leading, 12)
                             .frame(height: 50)
                         }
                     }
                 }
            } else {
                Spacer()
            }
//            Spacer()
            Divider().padding([.leading, .trailing])
            
            VkButtonView(with: "Опубликовать подкаст",
                         navTitle: "",
                         at: PodcastCreatedView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true),
                         isActive: true).frame(width: 351, height: 44)
            
//            Spacer()
        }
        
    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView(podcastPost: PodcastPost(title: "Подкаст", description: "Подкаст, который рассказывает про то, как в мире много прекрасных вещей, которые можно совершить, а так же сколько людей, которые могут помочь вам в реализации ваших щаветных мечт"))
    }
}
