import SwiftUI

struct LoginView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing:20){
            TextField("Email", text: $viewModel.email)
                .font(ThemeFonts.bodyLarge)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            ZStack (alignment: .trailing) {
                if viewModel.showPassword {
                    TextField("Senha", text: $viewModel.password)
                        .font(ThemeFonts.bodyLarge)
                        .textFieldStyle(.roundedBorder)
                } else {
                    SecureField("Senha", text: $viewModel.password)
                        .font(ThemeFonts.bodyLarge)
                        .textFieldStyle(.roundedBorder)
                }
                Button( action : {
                    viewModel.togglePasswordVisibility()
                }) {
                    Image(systemName: viewModel.showPassword ? "eye.slash" : "eye")
                }
                .padding(.trailing, 10)
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
