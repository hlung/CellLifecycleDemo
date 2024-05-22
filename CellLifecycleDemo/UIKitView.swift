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
    uiView.label.text = text
  }
}

class TrackedUIView: UIView {
  static var viewCount = 0

  let text: String
  let label = UILabel()

  init(text: String) {
    self.text = text
    super.init(frame: .zero)
    Self.viewCount += 1
    print(type(of: self), "  init ✅", text, "address:", Unmanaged.passUnretained(self).toOpaque(), "(total view count: \(Self.viewCount))")

    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  deinit {
    Self.viewCount -= 1
    print(type(of: self), "deinit ❌", text, "address:", Unmanaged.passUnretained(self).toOpaque(), "(total view count: \(Self.viewCount))")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
