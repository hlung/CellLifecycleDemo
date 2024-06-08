import SwiftUI

struct DataView: View {

  @StateObject var dataController = DataController()

  var body: some View {
    ZStack {
      if dataController.rows.isEmpty {
        ProgressView()
      }
      else {
        List {
          ForEach(dataController.rows) { row in
            // Type 1: No Nested View
            // This `dataController.objectWillChange.send()` is needed
            // because DataView doesn't consider each row as an @ObservedObject,
            // so we need to nudge it a bit.
            // (I noticed scrolling is not as smooth as type 2.)
//            if row.values.isEmpty {
//              ProgressView()
//                .frame(height: 94)
//                .frame(maxWidth: .infinity)
//                .task {
//                  try? await row.load()
//                  dataController.objectWillChange.send() // <- !!!
//                }
//            }
//            else {
//              // This won't work because SwiftUI doesn't know that
//              // `row` should be an @ObservedObject.
//              ScrollView(.horizontal) {
//                LazyHStack {
//                  ForEach(row.values) { value in
//                    CellView(text: "(\(row.id),\(value.id)) \(value)")
//                      .frame(width: 100, height: 94)
//                  }
//                }
//              }
//              .frame(height: 94)
//              .listRowInsets(EdgeInsets(.zero))
//            }

            // Type 2: Nested View with @ObservedObject row
            DataRowView(row: row)
              .listRowInsets(EdgeInsets(.zero))
              .task {
                try? await row.load()
              }
          }
        }
        .listStyle(.plain)
      }
    }
    .task {
      try? await dataController.load()
    }
  }
}

struct DataRowView: View {
  @ObservedObject var row: DataRow

  var body: some View {
    if row.values.isEmpty {
      ProgressView()
        .frame(height: 94)
        .frame(maxWidth: .infinity)
    }
    else {
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(row.values) { value in
            CellView(text: "(\(row.id),\(value.id)) \(value.value)")
              .frame(width: 100, height: 94)
          }
        }
      }
    }
  }
}

#Preview {
  DataView()
}

