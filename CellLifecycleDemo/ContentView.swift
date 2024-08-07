//
//  ContentView.swift
//  CellLifecycleDemo
//
//  Created by Kolyutsakul, Thongchai on 18/4/24.
//

import SwiftUI

struct ContentView: View {

  let max = 200

  @FocusState var focusedIndex: Int?

  var body: some View {
    NavigationStack {
      List {
        Section("Others") {

          NavigationLinkWithTitle("Focus testing") {
            FocusTestingView()
          }

          NavigationLinkWithTitle("Nested ObservableObject") {
            DataView()
          }

        }

        Section("1D (\(max) elements)") {

          NavigationLinkWithTitle("List") {
            List {
              ForEach(1...max, id: \.self) { i in
                CellView(text: "\(i)")
                  .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
              }
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 0)
          }

          NavigationLinkWithTitle("LazyVStack") {
            ScrollView {
              LazyVStack {
                ForEach(1...max, id: \.self) { i in
                  CellView(text: "\(i)")
                }
              }
            }
          }

          NavigationLinkWithTitle("VStack") {
            ScrollView {
              VStack {
                ForEach(1...max, id: \.self) { i in
                  CellView(text: "\(i)")
                }
              }
            }
          }

        }

        Section("2D (\(max) elements)") {

          // "Grid view" layout
          NavigationLinkWithTitle("LazyVGrid with masthead in safeAreaInset") {
            let columns = [
              GridItem(spacing: 8),
              GridItem(spacing: 8),
              GridItem(spacing: 8),
              GridItem(spacing: 8),
            ]

            ScrollViewReader { proxy in
              ScrollView {
                LazyVGrid(columns: columns) {
                  ForEach(1...max, id: \.self) { i in
                    CellView(text: "\(i)")
                      .frame(height: 188)
                      .focused($focusedIndex, equals: i)
                      .id(i)

                  }
                }
              }
              .safeAreaInset(edge: .top, content: {
                // Adding this with VStack interferes with scrolling,
                // safeAreaInset seems to work.
                mastHeadView
              })
              .onChange(of: focusedIndex) { newValue in
                print("focusedIndex: \(newValue)")
                withAnimation(.easeIn) {
                  proxy.scrollTo(newValue, anchor: .top)
                }
              }
            }
          }

          NavigationLinkWithTitle("LazyVGrid with top padding") {
            let columns = [
              GridItem(spacing: 8),
              GridItem(spacing: 8),
              GridItem(spacing: 8),
              GridItem(spacing: 8),
            ]

            ScrollViewReader { proxy in
              ScrollView {
                LazyVGrid(columns: columns) {
                  ForEach(1...max, id: \.self) { i in
                    CellView(text: "\(i)")
                      .frame(height: 188)
                      .focused($focusedIndex, equals: i)
                      .id(i)
                  }
                }
              }
              .padding(.top, 10) // <---
              .onChange(of: focusedIndex) { newValue in
                print("focusedIndex: \(newValue)")
                withAnimation(.easeIn) {
                  proxy.scrollTo(newValue, anchor: .top)
                }
              }
            }
          }

          NavigationLinkWithTitle("LazyVGrid") {
            let columns = [
              GridItem(spacing: 8),
              GridItem(spacing: 8),
              GridItem(spacing: 8),
              GridItem(spacing: 8),
            ]

            ScrollView {
              LazyVGrid(columns: columns) {
                ForEach(1...max, id: \.self) { i in
                  CellView(text: "\(i)")
                    .frame(height: 188)
                }
              }
            }
          }

          NavigationLinkWithTitle("Grid") {
            ScrollView {
              Grid {
                ForEach(1...max, id: \.self) { i in
                  if i % 2 == 1 { // This is a hack, but should be ok for our purpose
                    GridRow {
                      CellView(text: "\(i)")
                        .frame(height: 188)
                      CellView(text: "\(i + 1)")
                        .frame(height: 188)
                    }
                  }
                }
              }
            }
          }

        }

        Section("2D h scroll (\(max) x 100 elements)") {

          // "Content row" layout
          NavigationLinkWithTitle("List x LazyHStack") {
            List {
              ForEach(1...max, id: \.self) { i in
                ScrollView(.horizontal) {
                  LazyHStack {
                    ForEach(1..<100) { j in
                      CellView(text: "(\(i), \(j))")
                        .frame(width: 100, height: 94)
                    }
                  }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
              }
            }
            .listStyle(.plain)
          }

          NavigationLinkWithTitle("LazyVStack x LazyHStack") {
            ScrollView {
              LazyVStack {
                ForEach(1...max, id: \.self) { i in
                  ScrollView(.horizontal) {
                    LazyHStack {
                      ForEach(1..<100) { j in
                        CellView(text: "(\(i), \(j))")
                          .frame(width: 100, height: 94)
                      }
                    }
                  }
                }
              }
            }
          }

        }

      }
      .navigationTitle("Cell Lifecycle Demo")

    }

  }

  var mastHeadView: some View {
    Text("Masthead")
      .font(.title)
      .frame(height: 300)
      .frame(maxWidth: .infinity)
      .background(.green.opacity(0.2))
      .overlay(alignment: .bottomLeading) {
        Text("Test Header")
      }
  }
}

struct CellView: View {
  let text: String

  var body: some View {
    Button(action: {}) {
      UIKitView(text: text)
    }
    .frame(minHeight: 32)
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

