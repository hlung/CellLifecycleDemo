//
//  ContentView.swift
//  CellLifecycleDemo
//
//  Created by Kolyutsakul, Thongchai on 18/4/24.
//

import SwiftUI

struct ContentView: View {

  let range = 1...1000

  var body: some View {
    NavigationStack {
      List {

        Section("1D") {

          NavigationLinkWithTitle("List") {
            List {
              ForEach(range, id: \.self) { i in
                CellView(text: "\(i)")
              }
            }
          }

          NavigationLinkWithTitle("LazyVStack") {
            ScrollView {
              LazyVStack {
                ForEach(range, id: \.self) { i in
                  CellView(text: "\(i)")
                }
              }
            }
          }

          NavigationLinkWithTitle("VStack") {
            ScrollView {
              VStack {
                ForEach(range, id: \.self) { i in
                  CellView(text: "\(i)")
                }
              }
            }
          }
        }

        Section("2D") {

          // Content row mode?
          NavigationLinkWithTitle("List / LazyHStack") {
            List {
              ForEach(range, id: \.self) { i in
                ScrollView(.horizontal) {
                  LazyHStack {
                    ForEach(1..<100) { j in
                      CellView(text: "(\(i), \(j))")
                        .frame(width: 80, height: 80)
                    }
                  }
                }
              }
            }
          }

          NavigationLinkWithTitle("LazyVStack / LazyHStack") {
            ScrollView {
              LazyVStack {
                ForEach(range, id: \.self) { i in
                  ScrollView(.horizontal) {
                    LazyHStack {
                      ForEach(1..<100) { j in
                        CellView(text: "(\(i), \(j))")
                          .frame(width: 100, height: 100)
                      }
                    }
                  }
                }
              }
            }
          }

          NavigationLinkWithTitle("Grid") {
            ScrollView {
              Grid {
                ForEach(range, id: \.self) { i in
                  if i % 2 == 1 {
                    GridRow {
                      CellView(text: "\(i)")
                      CellView(text: "\(i + 1)")
                    }
                  }
                }
              }
            }
          }

          // Grid mode
          NavigationLinkWithTitle("LazyVGrid") {
            let columns = [
              GridItem(spacing: 32),
              GridItem(spacing: 32)
            ]
            ScrollView {
              LazyVGrid(columns: columns) {
                ForEach(range, id: \.self) { i in
                  CellView(text: "\(i)")
                }
              }
            }
          }

        }

      }
      .navigationTitle("Cell Lifecycle Demo")

    }

  }
}

struct CellView: View {
  let text: String

  var body: some View {
    Button(action: {}) {
      UIKitView(text: text)
    }
    .frame(height: 32)
    .frame(maxWidth: .infinity)
  }
}

struct NavigationLinkWithTitle<Content: View>: View {
  let title: String
  @ObservedObject var tracker = Tracker.shared
  var content: Content

  init(_ title: String, @ViewBuilder content: () -> Content) {
    self.title = title
    self.content = content()
  }

  var body: some View {
    NavigationLink(title) {
      content
        .navigationTitle(title)
        .toolbar {
          Text("Cell count: \(tracker.cellCount)")
        }
    }
  }
}

#Preview {
  ContentView()
}

