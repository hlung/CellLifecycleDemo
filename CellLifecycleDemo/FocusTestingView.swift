import SwiftUI

struct FocusTestingView: View {

  @Namespace var mainNamespace
//  @Namespace var subNamespace
  @Environment(\.resetFocus) var resetFocus
  @State var selectedTab: String?

  var body: some View {
    HStack {
      VStack {
        Spacer()
        Button ("1") {}
        Button ("2") {}
        Button ("3") {}
        Button ("4") {}
        Button ("5") {}
        Spacer()
      }

      VStack {
        Spacer()
        Button ("6") {}
          .prefersDefaultFocus(in: mainNamespace)
        Button ("7") {}
        Button ("8") {}
        Button ("9") {}
        Button ("10") {}
        Spacer()
      }
//      .focusScope(mainNamespace)
    }
    .focusScope(mainNamespace) // also not working
    .onExitCommand(perform: {
      resetFocus(in: mainNamespace)
    })
    .frame(width: 500)
    .background(.brown)
    .safeAreaInset(edge: .leading, spacing: 0) {
      tabBarView
    }
  }

  private var tabBarView: some View {
    ZStack {
      VStack {
        Spacer()
        Button ("A") {}
//          .prefersDefaultFocus(in: mainNamespace)
        Button ("B") {}
        Button ("C") {}
        Button ("D") {}
        Button ("E") {}
        Spacer()
      }
//      .focusScope(subNamespace)
      .background(.regularMaterial)
    }
  }

}

struct Tab: Equatable, Hashable, Identifiable {
  let id: String
  let imageName: String
  let title: String

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension Tab {
  static let allTabs: [Tab] = [.search, .home, .me, .vikiPass, .settings]

  static let home = Tab(
    id: "home", imageName: "tab_icon_home", title: "Home"
  )
  static let search = Tab(
    id: "search", imageName: "tab_icon_search", title: "Search"
  )
  static let me = Tab(
    id: "me", imageName: "tab_icon_me", title: "Me"
  )
  static let vikiPass = Tab(
    id: "vikiPass", imageName: "tab_icon_vikipass", title: "Pass"
  )
  static let settings = Tab(
    id: "settings", imageName: "tab_icon_settings", title: "Settings"
  )
}

