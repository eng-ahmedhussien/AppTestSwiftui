//
//  WebView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 22/05/2025.
//

//
//import WebKit
//import SwiftUI
//
//struct WebView: UIViewRepresentable {
//    
//    let content: URLWebViewTypeEnum  // Now Published to trigger updates
//    var isUserInteractionEnabled: Bool = true
//
//    
//    func makeUIView(context: Context) -> WKWebView {
//        
//        // Create a WKWebView configuration
//        let webViewConfiguration = WKWebViewConfiguration()
//        
//        // Create webpage preferences to allow JavaScript
//        let webpagePreferences = WKWebpagePreferences()
//        webpagePreferences.allowsContentJavaScript = true // Enable JavaScript
//        
//        // Assign the preferences to the configuration
//        webViewConfiguration.defaultWebpagePreferences = webpagePreferences
//
//
//        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
//        webView.isUserInteractionEnabled = isUserInteractionEnabled
//        loadContent(webView: webView)
//        
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        loadContent(webView: uiView)
//    }
//
//    private func loadContent(webView: WKWebView) {
//        switch content {
//        case .url(let url):
//            webView.load(url)
//        case .html(let script, let url):
//            webView.loadHTMLString(script, baseURL: url)
//        }
//    }
//}
//
//enum URLWebViewTypeEnum {
//    case url(url: URLRequest)
//    case html(script: String, url: URL? = nil)
//}
//
//class WebViewModel: ObservableObject {
////    @Published var isLoading: Bool = false
////    @Published var canGoBack: Bool = false
////    @Published var shouldGoBack: Bool = false
////    @Published var title: String = ""
//    @Published var content: URLWebViewTypeEnum  // Now Published to trigger updates
//
//    init(content: URLWebViewTypeEnum) {
//        self.content = content
//    }
//}
//
//
//struct webViewContentView: View {
//    var body: some View {
//    
//            VStack(alignment: .leading, spacing: 16) {
//                
//                HStack(alignment: .top, spacing: 20) {
//                    Image("deliveryTruck")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 30, height: 36)
//                        .padding(.leading, 10)
//                    
//                    VStack(alignment: .leading, spacing: 12) {
//                        Text("Package delivery work hours")
//                            .appFont(.body)
//                        
//                        Text(ConvertHtmlToString(AppManager.shared.siteConfigViewModel.data?.deliveryInstructionWeekDayMsg ?? ""))
//                            .appFont(.subheadline)
//                            .foregroundStyle(.gray)
//                            .fixedSize(horizontal: false, vertical: true)
//
//                        Divider().frame(width: 200)
//
//                        Text(ConvertHtmlToString(AppManager.shared.siteConfigViewModel.data?.deliveryInstructionWeekEndMsg ?? ""))
//                            .appFont(.subheadline)
//                            .foregroundStyle(.gray)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                }
//                .padding()
//                
//                Spacer()
//
//            }
//            .background(
//                Image("adAssets02")
//                    .resizable()
//                    .scaledToFill()
//                    .clipped()
//            )
//           // .cornerRadius(10)
//            .padding(.vertical)
//        
////        VStack{
////            WebView(content: .html(script: " <strong>من السبت إلى الخميس</strong> من الساعة 8 صباحًا إلى الساعة 2 صباحًا"))
////                .frame( height: 20)
////                .padding()
////                .border(.red)
////        
////            
////            WebViewForHtmlScript(htmlContent: " <strong>من السبت إلى الخميس</strong> من الساعة 8 صباحًا إلى الساعة 2 صباحًا", dynamicHeight: .constant(50), isLoading: .constant(false))
////                .frame(height: 50)
////                .padding()
////                .foregroundStyle(.red)
////                .border(.red)
////            
//            
////            let htmlString = "<strong>من السبت إلى الخميس</strong> من الساعة 8 صباحًا إلى الساعة 2 صباحًا"
////            let cleanedString = htmlString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
////            
////            Text(cleanedString)
//            
//            
//
////            let htmlString = "<strong>من السبت إلى الخميس</strong> من الساعة 8 صباحًا إلى الساعة 2 صباحًا"
////
////            if let data = htmlString.data(using: .utf8),
////               let attributed = try? NSAttributedString(data: data,
////                                                         options: [.documentType: NSAttributedString.DocumentType.html,
////                                                                   .characterEncoding: String.Encoding.utf8.rawValue],
////                                                         documentAttributes: nil) {
////                let plainText = attributed.string
////                Text(plainText)
//
//            }
//        }
//    }
//}
//
//#Preview{
//    webViewContentView()
//}
//
//
//struct WebViewHtmlScriptWrapper: View {
//    let htmlContent: String
//    @Binding var isExpanded: Bool
//    @State private var webContentHeight: CGFloat = 100  // Start with default height
//    @State private var isLoading: Bool = true
//    let defaultHeight: CGFloat  // Default height for collapsed state
//
//    var body: some View {
//        VStack {
//            if isLoading {
//                ProgressView()
//                    .frame(height: 50)
//                    .padding()
//            }
//
//            WebViewForHtmlScript(
//                htmlContent: htmlContent,
//                dynamicHeight: $webContentHeight,
//                isLoading: $isLoading
//            )
//            .frame(height: isExpanded ? webContentHeight : defaultHeight)  // Use defaultHeight when collapsed
//            .cornerRadius(12)
//            .padding(.horizontal)
//        }
//    }
//}
//
//// MARK: - WebViewForHtmlScript
//
//struct WebViewForHtmlScript: UIViewRepresentable {
//    let htmlContent: String
//    @Binding var dynamicHeight: CGFloat
//    @Binding var isLoading: Bool
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.scrollView.isScrollEnabled = false  // Disable internal scrolling
//        webView.navigationDelegate = context.coordinator
//        loadHTMLContent(webView)
//        return webView
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        // No updates required here
//    }
//
//    private func loadHTMLContent(_ webView: WKWebView) {
//        let optimizedHTML = """
//        <html>
//        <head>
//            <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
//            <style>
//                body { margin: 0; padding: 0; font-size: 18px; overflow-x: hidden; }
//                img { max-width: 100%; height: auto; object-fit: cover; }
//                html, body { width: 100%; min-height: 100%; overflow-y: hidden; }
//                * { box-sizing: border-box; }
//                a { color: blue; text-decoration: underline; }
//            </style>
//        </head>
//        <body>
//            \(htmlContent)
//        </body>
//        </html>
//        """
//        webView.loadHTMLString(optimizedHTML, baseURL: nil)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: WebViewForHtmlScript
//
//        init(_ parent: WebViewForHtmlScript) {
//            self.parent = parent
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            webView.evaluateJavaScript("document.documentElement.scrollHeight") { result, error in
//                guard let height = result as? CGFloat, error == nil else { return }
//                DispatchQueue.main.async {
//                    self.parent.dynamicHeight = max(1, height)  // Avoid height 0
//                    self.parent.isLoading = false  // Hide loading indicator
//                }
//            }
//        }
//
//        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//            if let url = navigationAction.request.url {
//                if navigationAction.navigationType == .linkActivated {
//                    // Open the link in Safari
//                    UIApplication.shared.open(url)
//                    
//                    // Cancel navigation within the web view
//                    decisionHandler(.cancel)
//                    return
//                }
//            }
//            
//            // Allow navigation for non-link actions
//            decisionHandler(.allow)
//        }
//    }
//}
//
//
