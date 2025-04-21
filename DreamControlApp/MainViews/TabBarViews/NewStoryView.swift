import SwiftUI

struct NewStoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var autoStory = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    private let characterLimit = 400
    
    @StateObject private var apiService = APIService()
    
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
                            
                            Text(title.isEmpty ? "Введите название" : title)
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
                .shadow(radius: 10)
                .ignoresSafeArea(.all)
                .overlay(
                    ScrollView {
                        VStack(spacing: 16) {
                            Text("Название истории")
                                .font(.headline)
                            TextField("Введите название", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            Toggle("Авто-история", isOn: $autoStory)
                                .padding(.horizontal)
                            
                            Text("Описание")
                                .font(.headline)
                            
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
                            
                            Text("Количество символов: \(description.count)/\(characterLimit)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
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
                                        .frame(height: 50)
                                        .overlay(
                                            Text("Отмена")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                        )
                                }
                                
                                Button(action: {
                                    createStory()
                                }) {
                                    Rectangle()
                                        .foregroundColor(Color("PrimaryColor"))
                                        .cornerRadius(100)
                                        .frame(height: 50)
                                        .overlay(
                                            Text("Сохранить")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                        )
                                }
                                .disabled(title.isEmpty || description.isEmpty)
                            }
                            .padding(.horizontal, 100)
                        }
                        .padding(.top)
                    }
                )
                .padding(.horizontal)
        }
    }
    
    private func createStory() {
        errorMessage = ""
        guard !title.isEmpty, !description.isEmpty else {
            errorMessage = "Заполните все поля."
            return
        }
        
        if autoStory {
            isLoading = true
            apiService.sendPrompt(description) { result in
                DispatchQueue.main.async {
                    isLoading = false
                    if let generatedText = result {
                        onSave(title, generatedText)
                        dismiss()
                    } else {
                        errorMessage = "Не удалось сгенерировать историю. Попробуйте позже."
                    }
                }
            }
        } else {
            onSave(title, description)
            dismiss()
        }
    }
}


#Preview {
    NewStoryView{_, _ in }
}
