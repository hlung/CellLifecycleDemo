import Foundation

@MainActor
class DataController: ObservableObject {

  @Published var rows: [DataRow] = []

  func load() async throws {
    print("\(type(of: self)) rows loading...")
    try await Task.sleep(for: .seconds(1))
    for i in 1...200 {
      let row = DataRow(id: i)
      rows.append(row)
    }
    print("\(type(of: self)) rows loaded \(rows.count)")
  }

  func reset() {
    rows = []
  }

}

@MainActor
class DataRow: ObservableObject, Identifiable, CustomStringConvertible {

  let id: Int
  @Published var values: [Value]

  init(id: Int, values: [Value] = []) {
    self.id = id
    self.values = values
  }

  func load() async throws {
    guard values.isEmpty else { return }
    print("\(type(of: self)) values loading...")
    // This sleep can throw if the view goes out of screen before it finished loading!!!
    try await Task.sleep(for: .seconds(1))
    for i in 1...24 {
      values.append(Value(id: i, value: Int.random(in: 1...99)))
    }
    print("\(type(of: self)) values loaded \(values.count)")
  }

  nonisolated
  var description: String {
    "\(type(of: self)) id: \(id)"
  }

}

struct Value: Identifiable {
  let id: Int
  let value: Int
}
