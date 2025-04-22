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
    
    @StateObject private var apiService = APIService()
    @State private var warningMessage: String? = nil
    var onSave: (String, String) -> Void
    
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
                                .font(.headline)
                            
                            Text(storyTitle.isEmpty ? "Введите название" : storyTitle)
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
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
                            InputFieldView(title: "Название истории", placeholder: "Введите название", text: $storyTitle)
                                .onChange(of: storyTitle) { newValue in
                                    // Ограничиваем количество символов в названии
                                    if newValue.count > titleLimit {
                                        storyTitle = String(newValue.prefix(titleLimit))
                                    }
                                    validateFields() // Проверяем при изменении заголовка
                                }
                            if autoStory {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("Описание")
                                            .foregroundColor(Color("TextColor"))
                                            .font(.custom("", size: 20))
                                    }
                                    
                                    ZStack {
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
                                        .font(.callout)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                         autoStory.toggle()
                                     }
                                     validateFields()// Проверяем поля при переключении
                                }, label: {
                                    HStack {
                                        Circle()
                                            .strokeBorder(autoStory ? Color("Prem1") : Color.white, lineWidth: 2)
                                            .background(Circle().fill(autoStory ? Color("Prem1") : Color.clear))
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Авто-история")
                                            .font(.title3)
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
                            
                            
                            
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            
                            if isLoading {
                                ProgressView("Генерация истории...")
                                    .padding()
                            }
                            
                            HStack(spacing: 20) {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Rectangle()
                                        .foregroundColor(Color("PrimaryColor"))
                                        .cornerRadius(100)
                                        .frame(width: 135, height: 50)
                                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                        .overlay(
                                            Text("Отмена")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .bold()
                                        )
                                }
                                
                                Button(action: {
                                    createStory()
                                }) {
                                    Rectangle()
                                        .foregroundColor(Color("PrimaryColor"))
                                        .cornerRadius(100)
                                        .frame(width: 135, height: 50)
                                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                        .overlay(
                                            Text("Сохранить")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .bold()
                                        )
                                }
                                .disabled(storyTitle.isEmpty || description.isEmpty)
                            }
                            .padding(.horizontal, 100)
                        }
                        .padding(.top)
                    }
                )
                .padding(.horizontal)
        }
    }
    
    private func validateFields() -> Bool {
        // Убираем пробелы из начала и конца названия
        let trimmedTitle = storyTitle.trimmingCharacters(in: .whitespaces)
        
        // Проверка полей на пустоту или состоящие только из пробелов
        if trimmedTitle.isEmpty {
            warningMessage = "Поле названия истории не должно быть пустым!"
            return false
        } else if autoStory && storyDescription.isEmpty {
            warningMessage = "Поле описания истории не должно быть пустым!"
            return false
        } else {
            warningMessage = nil
            return true
        }
    }

    private func createStory() {
        errorMessage = ""
        guard !storyTitle.isEmpty, !description.isEmpty else {
            errorMessage = "Заполните все поля."
            return
        }
        
        if autoStory {
            isLoading = true
            let finalPrompt = "Используя это описание: \"\(description)\", создай вдохновляющую историю, чтобы человек мог визуализировать свой успех. История не долнжа вызывать никакиз негаивных эмоций."
            apiService.sendPrompt(finalPrompt) { result in
                DispatchQueue.main.async {
                    isLoading = false
                    if let generatedText = result {
                        onSave(storyTitle, generatedText)
                        dismiss()
                    } else {
                        errorMessage = "Не удалось сгенерировать историю. Попробуйте позже."
                    }
                }
            }
        } else {
            onSave(storyTitle, description)
            dismiss()
        }
    }
}


#Preview {
    NewStoryView{_, _ in }
}
