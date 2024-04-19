import UIKit
import SwiftUI

struct UIKitView: UIViewRepresentable {
  var text: String = ""

  func makeUIView(context: Context) -> TrackedUIView {
    let view = TrackedUIView(text: text)
    view.backgroundColor = .lightGray
    return view
  }

  func updateUIView(_ uiView: TrackedUIView, context: Context) {
  }
}


class TrackedUIView: UIView {
  static var viewCount = 0

  let text: String

  init(text: String) {
    self.text = text
    super.init(frame: .zero)
    Self.viewCount += 1
    print(type(of: self), "✅   init", text, "(viewCount: \(Self.viewCount))", "address:", Unmanaged.passUnretained(self).toOpaque())
  }

  deinit {
    Self.viewCount -= 1
    print(type(of: self), "❌ deinit", text, "(viewCount: \(Self.viewCount))", "address:", Unmanaged.passUnretained(self).toOpaque())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
