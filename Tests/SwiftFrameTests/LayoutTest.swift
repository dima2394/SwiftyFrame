//
//  Created by Dmitriy Verennik on 22.03.2022.
//

import XCTest

final class LayoutTest: BaseTest {
    
    func testEdgeLayout() {
        let insets: UIEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
        firstView.configureFrame {
            $0.edges(insets)
        }
        XCTAssertEqual(firstView.frame, CGRect(x: 15, y: 15, width: 770, height: 770))
    }
}
