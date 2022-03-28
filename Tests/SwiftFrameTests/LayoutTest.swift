//
//  Created by Dmitriy Verennik on 22.03.2022.
//

import XCTest

final class LayoutTest: BaseTest {
    
    func testEdgeLayout() {
        let insets: UIEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
        firstView.frame {
            $0.edges(insets)
        }
        XCTAssertEqual(firstView.frame, CGRect(x: 15, y: 15, width: 770, height: 770))
    }
    
    func testEdgeWithSuperView() {
        
        let insets: UIEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
        let firstViewEtalonRect = CGRect(x: 15, y: 15, width: 770, height: 770)
        firstView.frame {
            $0.edges(into: contentView, insets: insets)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
}
