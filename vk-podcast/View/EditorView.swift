//
//  EditorView.swift
//  vk-podcast
//
//  Created by milkyway on 16.09.2020.
//  Copyright © 2020 belotserkovtsev. All rights reserved.
//

import SwiftUI

struct EditorView: View {
    @ObservedObject var podcastPost: PodcastPost
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(podcastPost: PodcastPost){
        self.podcastPost = podcastPost
//        self.presentationMode.wrappedValue.dismiss()
    }
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("backButton").frame(width: 64, alignment: .leading)
        }
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Divider().padding()
            Image("edit").frame(width: 351, height: 26+96+60).padding(.bottom, 12)
            
            HStack {
                Text("ТАЙМКОДЫ")
                    .foregroundColor(Color("sublineTextGray"))
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.leading, 12)
                Spacer()
            }.frame(width: 375, height: 40)
            
            TimeCodeView(podcastPost: podcastPost)
                .padding(.bottom, 12)
            
            HStack {
                Group {
                    Image("bluePlus")
                    .padding(.leading, 13)
                    Text("Добавить таймкод")
                        .font(.system(size: 16))
                    .foregroundColor(Color("buttonLightBlue"))
                }.onTapGesture {
                    self.podcastPost.pushTimeCode()
                }
                
                Spacer()
            }.frame(width: 375, height: 48)
            
            HStack {
                Text("Отметки времени с названием темы. Позволяют слушателям легче путешествовать по подкасту")
                    .foregroundColor(Color("sublineTextGray"))
                    .font(.system(size: 13, weight: .regular))
                    .padding(.leading, 12)
                
                Spacer()
            }.frame(width: 375, height: 60)
            Spacer()
        }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
        .onDisappear {
            self.podcastPost.clearEmptyTimeCodes()
        }
    }
}



struct TimeCodeView: View {
    @ObservedObject var podcastPost: PodcastPost
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(self.podcastPost.timeCodes) { item in
                HStack(spacing: 12) {
                    Image("cross")
                    
                    TimeCodeTitleView(for: item, at: self.podcastPost)
                    
                    TimeCodeTimeView(for: item, at: self.podcastPost)
                }
            }
        }
    }
}

struct TimeCodeTitleView: View {
    var item: Podcast.TimeCode
    @ObservedObject var podcastPost: PodcastPost
    
    @State var titleText: String = ""
    
    init(for item: Podcast.TimeCode, at podcast: PodcastPost) {
        self.item = item
        podcastPost = podcast
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color("fieldsGray"))
            HStack {
                TextField("Название темы", text: $titleText, onEditingChanged: { began in
                    if !began {
                        self.podcastPost.setTimecodeTitle(for: self.item, value: self.titleText)
                    }
                })
                    .font(.system(size: 16))
                    .padding(.leading, 12)
                Spacer()
            }
        }.onAppear{
            self.titleText = self.item.title ?? ""
        }
        .frame(width: 227, height: 44)
    }
}

struct TimeCodeTimeView: View {
    var item: Podcast.TimeCode
    @ObservedObject var podcastPost: PodcastPost
    
    @State var time: String = ""
    
    init(for item: Podcast.TimeCode, at podcast: PodcastPost) {
        self.item = item
        podcastPost = podcast
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color("fieldsGray"))
                .onTapGesture {
                    self.time = ""
            }
            TextFieldContainer("Время", text: Binding(
            get: {
                self.time
            }, set: { newValue in
                self.time = newValue
                self.podcastPost.setTimecodeTime(for: self.item, value: newValue)
                if self.time.count == 2 {
                    self.time.append(":")
                }
            }
            ))
                
                .disabled(self.time.count >= 5)
                .font(.system(size: 16))
                .padding(.leading, 12)
            
        }.onAppear{
            self.time = self.item.time ?? ""
        }
        .frame(width: 76, height: 44)
    }
}

struct TextFieldContainer: UIViewRepresentable {
    private var placeholder : String
    private var text : Binding<String>

    init(_ placeholder:String, text:Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }

    func makeCoordinator() -> TextFieldContainer.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {

        let innertTextField = UITextField(frame: .zero)
        innertTextField.placeholder = placeholder
        innertTextField.text = text.wrappedValue
        innertTextField.delegate = context.coordinator
        innertTextField.keyboardType = .numberPad

        context.coordinator.setup(innertTextField)

        return innertTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldContainer

        init(_ textFieldContainer: TextFieldContainer) {
            self.parent = textFieldContainer
        }

        func setup(_ textField:UITextField) {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            self.parent.text.wrappedValue = textField.text ?? ""

            let newPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(podcastPost: PodcastPost())
    }
}
