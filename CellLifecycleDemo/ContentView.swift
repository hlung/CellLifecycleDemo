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

          NavigationLink("List") {
            List {
              ForEach(1..<1000) { i in
                CellView(text: "\(i)")
              }
            }
            .navigationTitle("List")
          }

          NavigationLink("ScrollView + LazyVStack") {
            ScrollView {
              LazyVStack {
                ForEach(1..<1000) { i in
                  CellView(text: "\(i)")
                }
              }
            }
            .navigationTitle("ScrollView + LazyVStack")
          }

          NavigationLink("ScrollView + VStack") {
            ScrollView {
              VStack {
                ForEach(1..<1000) { i in
                  CellView(text: "\(i)")
                }
              }
            }
            .navigationTitle("ScrollView + VStack")
          }
        }

        Section("2D") {

          NavigationLink("List / ScrollView + LazyHStack") {
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
            .navigationTitle("List / ScrollView + LazyHStack")
          }

          NavigationLink("ScrollView + LazyVStack / ScrollView + LazyHStack") {
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
            .navigationTitle("List / ScrollView + LazyHStack")
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

#Preview {
  ContentView()
}
