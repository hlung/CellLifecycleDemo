import UIKit
import SwiftUI

struct UIKITView: UIViewRepresentable {
  func makeUIView(context: Context) -> TrackedUIView {
    let view = TrackedUIView()
    view.backgroundColor = .lightGray
    return view
  }

  func updateUIView(_ uiView: TrackedUIView, context: Context) {
  }
}


class TrackedUIView: UIView {
  static var viewCount = 0

  override init(frame: CGRect) {
    super.init(frame: frame)
    Self.viewCount += 1
    print(type(of: self), "init", "(viewCount: \(Self.viewCount))", Unmanaged.passUnretained(self).toOpaque())
  }

  deinit {
    Self.viewCount -= 1
    print(type(of: self), "deinit", "(viewCount: \(Self.viewCount))", Unmanaged.passUnretained(self).toOpaque())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
