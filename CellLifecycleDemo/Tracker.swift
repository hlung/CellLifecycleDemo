import Foundation

@MainActor
class Tracker: ObservableObject {
  static let shared = Tracker()
  @Published var cellCount = 0
}
