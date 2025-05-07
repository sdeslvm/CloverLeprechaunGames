import SwiftUI
import WebKit

// Страница с WebView
struct WebViewPage: View {
    var url: URL  // URL, который будет загружен в WebView

    var body: some View {
        CustomWebView(url: url)
            .edgesIgnoringSafeArea(.all)  // Растягиваем WebView на весь экран
    }
}

// Кастомный WebView с использованием UIViewRepresentable
struct CustomWebView: UIViewRepresentable {
    var url: URL  // Приняли URL для отображения

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct WebViewPage_Previews: PreviewProvider {
    static var previews: some View {
        WebViewPage(url: URL(string: "https://www.apple.com")!)
    }
}
