import SwiftUI

struct NewStoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var description = ""
    @State private var autoStory = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    @State private var storyTitle: String = ""
    @State private var storyDescription: String = ""
    private let characterLimit = 200
    private let titleLimit = 16 // Ограничение для названия
    @State private var triedToSubmit = false
    
    @StateObject private var apiService = APIService()
    @State private var warningMessage: String? = nil
    var onSave: (String, String) -> Void
    
    @State private var showingTip = false
    @AppStorage("userName") private var savedName: String = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image("CloudForDream")
                        VStack {
                            Text("Новая История")
                                .foregroundColor(Color("InactiveColor2"))
                                .bold()
                                .font(.custom("MontserratAlternates-Regular", size: 14))

                            Text(storyTitle.isEmpty ? "Какое-то название" : storyTitle)
                                .foregroundColor(.white)
                                .bold()
                                .font(.custom("MontserratAlternates-Regular", size: 20))
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .ignoresSafeArea(.all)
                .overlay(
                    ScrollView {
                        VStack(spacing: 16) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("PrimaryColor"))
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                                .padding(.trailing)
                            }
                            
                            VStack {
                                InputFieldView(title: "Название истории", placeholder: "Введите название", text: $storyTitle)
                                    .font(.custom("MontserratAlternates-Regular", size: 16))
                                    .onChange(of: storyTitle) { newValue in
                                        if newValue.count > titleLimit {
                                            storyTitle = String(newValue.prefix(titleLimit))
                                        }
                                    }
                                
                                HStack {
                                    Spacer()
                                    Text("Символов:\(storyTitle.count)/16")
                                    Spacer()
                                }
                                .font(.custom("MontserratAlternates-Regular", size: 14))
                                .foregroundColor(.gray)
                            }
                            if autoStory {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("Описание")
                                            .foregroundColor(Color("TextColor"))
                                            .font(.custom("MontserratAlternates-Regular", size: 16))
                                        Button(action: {
                                            showingTip.toggle()
                                        }) {
                                            Image("moreInfo")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                        .popover(isPresented: $showingTip) {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("Как написать хорошее описание:")
                                                    .font(.custom("MontserratAlternates-Regular", size: 24))
                                                Text("• Представьте, как выглядит ваша мечта.")
                                                Text("• Добавьте эмоции: что вы чувствуете?")
                                                Text("• Какие шаги ведут к ней?")
                                                Text("• Что вы увидите, услышите, ощутите?")
                                                Text("• Напишите дополнительную информацию о себе: кто вы сейчас, пол, возраст, интересы, и т.д.")
                                            }
                                            .font(.custom("MontserratAlternates-Regular", size: 14))
                                            .padding()
                                            .frame(width: 250)
                                        }
                                    }
                                    .padding(.horizontal, 12)

                                    ZStack(alignment: .topLeading) {
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 3
                                            )
                                            .background(Color.clear)
                                            .frame(width: 300, height: 200)

                                        ScrollView {
                                            TextField("Введите описание истории", text: $description, axis: .vertical)
                                                .font(.custom("MontserratAlternates-Regular", size: 14))
                                                .padding()
                                                .onChange(of: description) { newValue in
                                                    if newValue.count > characterLimit {
                                                        description = String(newValue.prefix(characterLimit))
                                                    }
                                                }
                                        }
                                        .frame(width: 280, height: 180)
                                    }
                                    .transition(.opacity.combined(with: .move(edge: .top)))

                                    Text("Количество символов: \(description.count)/\(characterLimit)")
                                        .font(.custom("MontserratAlternates-Regular", size: 14))
                                        .foregroundColor(.gray)
                                }
                            }

                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        autoStory.toggle()
                                    }
                                }, label: {
                                    HStack {
                                        Circle()
                                            .strokeBorder(autoStory ? Color("Prem1") : Color.white, lineWidth: 2)
                                            .background(Circle().fill(autoStory ? Color("Prem1") : Color.clear))
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Авто-история")
                                            .font(.custom("MontserratAlternates-Regular", size: 16))
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                    .padding()
                                    .background(Rectangle()
                                        .gradientForeground(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")])
                                        .cornerRadius(100)
                                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0))
                                })
                                Spacer()
                            }
                            
                            VStack {
                                if let validationMessage = combinedValidationMessage {
                                    Text(validationMessage)
                                        .foregroundColor(.red)
                                        .font(.callout)
                                        .padding(.top, 4)
                                }

                                
                                if !errorMessage.isEmpty {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                            
                            if isLoading {
                                ProgressView("Генерация истории...")
                                    .font(.custom("MontserratAlternates-Regular", size: 20))
                                    .padding()
                            }
                            
                                
                                Button(action: {
                                    createStory()
                                }) {
                                    Rectangle()
                                        .foregroundColor(Color("PrimaryColor"))
                                        .cornerRadius(100)
                                        .frame(height: 50)
                                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                        .overlay(
                                            Text("Сохранить")
                                                .font(.custom("MontserratAlternates-Regular", size: 22))
                                                .foregroundColor(.white)
                                                .bold()
                                        )
                            }
                                .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                )
                .padding(.horizontal)
        }
    }
    
    private var combinedValidationMessage: String? {
        guard triedToSubmit else { return nil }
        
        let isTitleEmpty = storyTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isDescriptionEmpty = autoStory && description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        switch (isTitleEmpty, isDescriptionEmpty) {
        case (true, true):
            return "Пожалуйста, заполните название и описание истории."
        case (true, false):
            return "Пожалуйста, заполните название истории."
        case (false, true):
            return "Пожалуйста, заполните описание истории."
        default:
            return nil
        }
    }
    
    init(
        storyTitle: String = "",
        storyDescription: String = "",
        onSave: @escaping (String, String) -> Void
    ) {
        self._storyTitle = State(initialValue: storyTitle)
        self._description = State(initialValue: storyDescription)
        self.onSave = onSave
    }

    private var isFormValid: Bool {
        let trimmedTitle = storyTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedTitle.isEmpty { return false }
        if autoStory && description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return false }
        return true
    }
    
    private func createStory() {
        Task {
            do {
                triedToSubmit = true
                errorMessage = ""
                
                guard isFormValid else {
                      return // Не продолжаем, если форма недействительна
                  }
                
                if autoStory {
                    isLoading = true
                    let finalPrompt = NewStoryView.getFinalPrompt(description: description, savedName: savedName)
                    let result = try await apiService.sendPrompt(finalPrompt)
                    DispatchQueue.main.async {
                        isLoading = false
                        onSave(storyTitle, result)
                        dismiss()
                    }
                } else {
                    onSave(storyTitle, description)
                    dismiss()
                }
            }
            catch {
                errorMessage = "Не удалось сгенерировать историю. Попробуйте позже."
            }
        }
    }
    
    internal static func getFinalPrompt(description: String, savedName: String) -> String {
        "Используя это описание: \"\(description)\", создай вдохновляющую историю, чтобы человек мог визуализировать свой успех. В качестве имени применяй имя: \"\(savedName)\". История не должна вызывать никаких негативных эмоций. Не превышай количество в 1800 букв, нельзя! Не пиши никаких обращений к пользователю, он не должен знать что ты ии"
    }
}


#Preview {
    NewStoryView{_, _ in }
}



