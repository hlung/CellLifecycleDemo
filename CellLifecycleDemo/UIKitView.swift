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

//  func sizeThatFits(_ proposal: ProposedViewSize, uiView: TrackedUIView, context: Context) -> CGSize? {
//    return uiView.label.sizeThatFits(CGSize(width: proposal.width ?? .infinity, height: proposal.height ?? .infinity))
//  }
}

class TrackedUIView: UIView {
  let text: String
  let label = UILabel()

  init(text: String) {
    self.text = text
    super.init(frame: .zero)
    Task { @MainActor in
      Tracker.shared.cellCount += 1
      let address: String = Unmanaged.passUnretained(self).toOpaque().debugDescription
      print("TrackedUIView", "  init ✅", text, "address: \(address)", "(total cell count: \(Tracker.shared.cellCount))")
    }

    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    addSubview(label)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leftAnchor.constraint(equalTo: leftAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
      label.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }

  deinit {
    // Need to capture some self var first, otherwise it will crash.
    let address: String = Unmanaged.passUnretained(self).toOpaque().debugDescription
    let text = self.text
    Task { @MainActor in
      Tracker.shared.cellCount -= 1
      print("TrackedUIView", "deinit ❌", text, "address: \(address)", "(total cell count: \(Tracker.shared.cellCount))")
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
