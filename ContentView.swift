import SwiftUI
import WebKit
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GotakuBrowser()
                .navigationTitle("AnimeVerse 50K")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            NotificationCenter.default.post(name: .animeVerseGoBack, object: nil)
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        Button {
                            NotificationCenter.default.post(name: .animeVerseReload, object: nil)
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
        }
        .tint(.white)
    }
}

private extension Notification.Name {
    static let animeVerseGoBack = Notification.Name("AnimeVerseGoBack")
    static let animeVerseReload = Notification.Name("AnimeVerseReload")
}

struct GotakuBrowser: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.allowsBackForwardNavigationGestures = true
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.backgroundColor = .black
        context.coordinator.webView = webView

        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.goBack),
            name: .animeVerseGoBack,
            object: nil
        )
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.reload),
            name: .animeVerseReload,
            object: nil
        )

        if let url = URL(string: "https://gotaku.to/") {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    final class Coordinator: NSObject {
        weak var webView: WKWebView?

        @objc func goBack() {
            guard let webView, webView.canGoBack else { return }
            webView.goBack()
        }

        @objc func reload() {
            webView?.reload()
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    }
}
