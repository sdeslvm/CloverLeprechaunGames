import Foundation


enum AvailableScreens {
    case MENU
    case SETTINGS
    case GAME
    case RULES
    case QUIZ
    case STATS
}

class NavGuard: ObservableObject {
    @Published var currentScreen: AvailableScreens = .MENU
    static var shared: NavGuard = .init()
}
