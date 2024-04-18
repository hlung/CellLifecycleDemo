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

        Section {

          NavigationLink("List") {
            List {
              ForEach(0..<1000) { i in
                ZStack {
                  UIKitView()
                  Text("\(i)")
                }
              }
            }
            .navigationTitle("List")
          }

          NavigationLink("ScrollView + LazyVStack") {
            ScrollView {
              LazyVStack {
                ForEach(0..<1000) { i in
                  ZStack {
                    UIKitView()
                    Text("\(i)")
                  }
                }
              }
            }
            .navigationTitle("ScrollView + LazyVStack")
          }

          NavigationLink("ScrollView + VStack") {
            ScrollView {
              VStack {
                ForEach(0..<1000) { i in
                  ZStack {
                    UIKitView()
                    Text("\(i)")
                  }
                }
              }
            }
            .navigationTitle("ScrollView + VStack")
          }
        }

        Section {

          NavigationLink("List / ScrollView + LazyHStack") {
            List {
              ForEach(0..<1000) { i in
                ScrollView(.horizontal) {
                  LazyHStack {
                    ForEach(0..<100) { j in
                      ZStack {
                        UIKitView()
                        Text("(\(i), \(j))")
                      }
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
                ForEach(0..<1000) { i in
                  ScrollView(.horizontal) {
                    LazyHStack {
                      ForEach(0..<100) { j in
                        ZStack {
                          UIKitView()
                          Text("(\(i), \(j))")
                        }
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

    }

  }
}

#Preview {
  ContentView()
}
