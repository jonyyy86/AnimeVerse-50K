import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GotakuBrowser()
                .navigationTitle("AnimeVerse 50K")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            NotificationCenter.default.post(
                                name: .goBack, object: nil
                            )
                        } label: {
                            Image(systemName: "chevron.left")
                        }

                        Button {
                            NotificationCenter.default.post(
                                name: .reloadPage, object: nil
                            )
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
        }
        .tint(.white)
    }
}

extension Notification.Name {
    static let goBack = Notification.Name("goBack")
    static let reloadPage = Notification.Name("reloadPage")
}

struct GotakuBrowser: UIViewRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .black
        webView.isOpaque = false

        webView.load(
            URLRequest(
                url: URL(string: "https://gotaku.to/")!
            )
        )

        context.coordinator.webView = webView

        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.goBack),
            name: .goBack,
            object: nil
        )

        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.reload),
            name: .reloadPage,
            object: nil
        )

        return webView
    }

    func updateUIView(
        _ uiView: WKWebView,
        context: Context
    ) {}

    class Coordinator: NSObject {
        weak var webView: WKWebView?

        @objc func goBack() {
            if webView?.canGoBack == true {
                webView?.goBack()
            }
        }

        @objc func reload() {
            webView?.reload()
        }
    }
}
