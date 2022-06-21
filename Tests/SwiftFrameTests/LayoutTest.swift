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

    func testTopToBottomLayout() {
        let firstViewEtalonRect = CGRect(x: 0, y: 15, width: 0, height: 770)
        firstView.frame {
            $0.top(inset: 15).bottom(inset: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
    
    func testVerticalLayout() {
        let firstViewEtalonRect = CGRect(x: 0, y: 15, width: 0, height: 770)
        firstView.frame {
            $0.vertical(margin: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
    
    func testLeftToRightLayout() {
        let firstViewEtalonRect = CGRect(x: 15, y: 0, width: 770, height: 0)
        firstView.frame {
            $0.left(inset: 15).right(inset: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
    
    func testHorizontalLayout() {
        let firstViewEtalonRect = CGRect(x: 15, y: 0, width: 770, height: 0)
        firstView.frame {
            $0.horizontal(margin: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }

    func testTopThreeSideLayout() {
        let firstViewEtalonRect = CGRect(x: 15, y: 15, width: 770, height: 0)
        firstView.frame {
            $0.leftTopRight(margin: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
    
    func testTopThreeSideWithHeightLayout() {
        let firstViewEtalonRect = CGRect(x: 15, y: 15, width: 770, height: 770)
        firstView.frame {
            $0.leftTopRight(margin: 15).bottom(inset: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
    
    func testBottomThreeSideLayout() {
        let firstViewEtalonRect = CGRect(x: 15, y: 785, width: 770, height: 0)
        firstView.frame {
            $0.leftBottomRight(margin: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
    
    func testBottomThreeSideWithHeightLayout() {
        let firstViewEtalonRect = CGRect(x: 15, y: 15, width: 770, height: 770)
        firstView.frame {
            $0.leftBottomRight(margin: 15).top(inset: 15)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
    }
    
    func testCenterToSuperview() {
        let firstViewEtalonRect = CGRect(x: 350, y: 350, width: 100, height: 100)
        firstView.frame {
            $0.squareSize(100).center()
        }
        
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
        XCTAssertEqual(firstView.center, contentView.center)
    }
    
    func testCenter() {
        let firstViewEtalonRect = CGRect(x: 350, y: 350, width: 100, height: 100)
        firstView.frame {
            $0.squareSize(100).center(to: contentView)
        }
        
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
        XCTAssertEqual(firstView.center, contentView.center)
    }
    
    func testCenterYTopRelation() {
        let firstViewEtalonRect = CGRect(x: 350, y: 350, width: 100, height: 100)
        firstView.frame {
            $0.squareSize(100).center(to: contentView)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
        
        let secondViewEtalonRect = CGRect(x: 350, y: 400, width: 100, height: 200)
        secondView.frame {
            $0.top(to: firstView.centerY)
            $0.right(to: firstView.right)
            $0.left(to: firstView.left)
            $0.height(200)
        }
        XCTAssertEqual(secondView.frame, secondViewEtalonRect)
    }
    
    func testCenterYBottomRelation() {
        let firstViewEtalonRect = CGRect(x: 350, y: 350, width: 100, height: 100)
        firstView.frame {
            $0.squareSize(100).center(to: contentView)
        }
        XCTAssertEqual(firstView.frame, firstViewEtalonRect)
        
        let secondViewEtalonRect = CGRect(x: 350, y: 200, width: 100, height: 200)
        secondView.frame {
            $0.bottom(to: firstView.centerY)
            $0.right(to: firstView.right)
            $0.left(to: firstView.left)
            $0.height(200)
        }
        XCTAssertEqual(secondView.frame, secondViewEtalonRect)
    }
}
