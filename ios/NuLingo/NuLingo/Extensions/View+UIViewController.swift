import UIKit
import SwiftUI

public extension View {
    var wrapped: UIHostingController<Self> {
        UIHostingController(rootView: self)
    }
}
