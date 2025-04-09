import SwiftUI

struct LoginView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme

    @StateObject private var viewModel: LoginViewModel
    
    init(appState: AppState){
        _viewModel = StateObject(wrappedValue: LoginViewModel(appState: appState))
    }
    
    var body: some View {
        VStack(spacing:20){
            TextField("Email", text: $viewModel.email)
                .font(ThemeFonts.bodyLarge)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .submitLabel(.done)
                .onSubmit {
                    Task {await viewModel.login()}
                }
            
            HStack () {
                Group{
                    if viewModel.showPassword {
                        TextField("Senha", text: $viewModel.password)
                    } else {
                        SecureField("Senha", text: $viewModel.password)
                    }
                }
                .font(ThemeFonts.bodyLarge)
                .textFieldStyle(.roundedBorder)
                .onChange(of: viewModel.password) { text in
                    viewModel.password = String(text.prefix(12))
                }
                .submitLabel(.done)
                .onSubmit {
                    Task { await viewModel.login() }
                }
            }.overlay(alignment: .trailing) {
                Image(systemName: !viewModel.showPassword ? "eye.slash" : "eye").onTapGesture {
                    viewModel.togglePasswordVisibility()
                }
                .padding(.trailing, 8)
            }
            
            Button(action: {
                Task {await viewModel.login()}
            }) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Entrar")
                }
            }
            .disabled(viewModel.isLoading)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .transition(.opacity)
            }
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 12)
        .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(themeManager.colors.containerBorder, lineWidth: 1))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.colors.containerDisabled)
    }
}

//#if DEBUG
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//         @StateObject var themeManager = ThemeManager()
//        LoginView()
//            .environmentObject(themeManager)
//            .preferredColorScheme(themeManager.colorScheme)
//    }
//}
//#endif
