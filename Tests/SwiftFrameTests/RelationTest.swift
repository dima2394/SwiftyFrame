//
//  Created by Dmitriy Verennik on 22.03.2022.
//

import XCTest

final class RelationTest: BaseTest {
 
    func testTopAndLeftRelation() throws {
        
        let firstViewEtalonRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        firstView.frame {
            $0.top().left().squareSize(100)
        }
        XCTAssertEqual(firstViewEtalonRect, firstView.frame)
        
        let secondViewEtalonRect = CGRect(x: 100, y: 100, width: 100, height: 100)
        secondView.frame {
            $0.top(to: firstView.bottom)
            $0.left(to: firstView.right)
            $0.squareSize(100)
        }
        XCTAssertEqual(secondView.frame, secondViewEtalonRect)
    }
    
    func testTopToBottomAndLeftRelation() throws {
        
        let firstViewEtalonRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        firstView.frame {
            $0.top().left().squareSize(100)
        }
        XCTAssertEqual(firstViewEtalonRect, firstView.frame)
        
        let secondViewEtalonRect = CGRect(x: 100, y: 0, width: 100, height: 100)
        secondView.frame {
            $0.top(to: firstView.top)
            $0.left(to: firstView.right)
            $0.squareSize(100)
        }
        XCTAssertEqual(secondViewEtalonRect, secondView.frame)
    }
    
    func testRightToLeftRelation() throws {
        
        let firstViewEtalonRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        firstView.frame {
            $0.top().left().squareSize(100)
        }
        XCTAssertEqual(firstViewEtalonRect, firstView.frame)
        
        let secondViewEtalonRect = CGRect(x: 110, y: 0, width: 680, height: 100)
        secondView.frame {
            $0.top(to: firstView.top)
            $0.left(to: firstView.right, inset: 10)
            $0.right(to: contentView.right, inset: 10)
            $0.bottom(to: firstView.bottom)
        }
        XCTAssertEqual(secondView.frame, secondViewEtalonRect)
    }
    
    func testLeftToRightRelation() throws {
        
        let firstViewEtalonRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        firstView.frame {
            $0.top().left().squareSize(100)
        }
        XCTAssertEqual(firstViewEtalonRect, firstView.frame)
        
        let secondViewEtalonRect = CGRect(x: 110, y: 0, width: 680, height: 100)
        secondView.frame {
            $0.top(to: firstView.top)
            $0.bottom(to: firstView.bottom)
            $0.right(to: contentView.right, inset: 10)
            $0.left(to: firstView.right, inset: 10)
        }
        XCTAssertEqual(secondView.frame, secondViewEtalonRect)
    }
    
    func testBottomToTopRelation() throws {
        
        let firstViewEtalonRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        firstView.frame {
            $0.top().left().squareSize(100)
        }
        XCTAssertEqual(firstViewEtalonRect, firstView.frame)
        
        let secondViewEtalonRect = CGRect(x: 110, y: 0, width: 680, height: 100)
        secondView.frame {
            $0.bottom(to: firstView.bottom)
            $0.top(to: firstView.top)
            $0.right(to: contentView.right, inset: 10)
            $0.left(to: firstView.right, inset: 10)
        }
        XCTAssertEqual(secondView.frame, secondViewEtalonRect)
    }
    
    func testRightToLeftInversionRelation() throws {
        
        let firstViewEtalonRect = CGRect(x: 700, y: 0, width: 100, height: 100)
        firstView.frame {
            $0.top().right().squareSize(100)
        }
        XCTAssertEqual(firstViewEtalonRect, firstView.frame)
        
        let secondViewEtalonRect = CGRect(x: 0, y: 0, width: 700, height: 100)
        secondView.frame {
            $0.top(to: firstView.top).right(to: firstView.left)
            $0.bottom(to: firstView.bottom).left(to: contentView.left)
        }
        XCTAssertEqual(secondView.frame, secondViewEtalonRect)
    }
}
