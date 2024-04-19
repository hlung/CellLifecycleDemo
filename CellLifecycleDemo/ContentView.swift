//
//  ContentView.swift
//  CellLifecycleDemo
//
//  Created by Kolyutsakul, Thongchai on 18/4/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List {

        Section("1D") {

          NavigationLinkWithTitle("List") {
            List {
              ForEach(1..<1000) { i in
                CellView(text: "\(i)")
              }
            }
          }

          NavigationLinkWithTitle("LazyVStack") {
            ScrollView {
              LazyVStack {
                ForEach(1..<1000) { i in
                  CellView(text: "\(i)")
                }
              }
            }
          }

          NavigationLinkWithTitle("VStack") {
            ScrollView {
              VStack {
                ForEach(1..<1000) { i in
                  CellView(text: "\(i)")
                }
              }
            }
          }
        }

        Section("2D") {

          NavigationLinkWithTitle("List / LazyHStack") {
            List {
              ForEach(1..<1000) { i in
                ScrollView(.horizontal) {
                  LazyHStack {
                    ForEach(1..<100) { j in
                      CellView(text: "(\(i), \(j))")
                    }
                  }
                }
              }
            }
          }

          NavigationLinkWithTitle("LazyVStack / LazyHStack") {
            ScrollView {
              LazyVStack {
                ForEach(1..<1000) { i in
                  ScrollView(.horizontal) {
                    LazyHStack {
                      ForEach(1..<100) { j in
                        CellView(text: "(\(i), \(j))")
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
                ForEach(1..<1000) { i in
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

          NavigationLinkWithTitle("LazyVGrid") {
            let columns = [
              GridItem(spacing: 32),
              GridItem(spacing: 32)
            ]
            ScrollView {
              LazyVGrid(columns: columns) {
                ForEach(1..<1000) { i in    
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
    ZStack {
      UIKitView(text: text)
      Text(text)
    }
  }
}

struct NavigationLinkWithTitle<Content: View>: View {
  let title: String
  var content: Content

  init(_ title: String, @ViewBuilder content: () -> Content) {
    self.title = title
    self.content = content()
  }

  var body: some View {
    NavigationLink(title) {
      content.navigationTitle(title)
    }
  }
}

#Preview {
  ContentView()
}
