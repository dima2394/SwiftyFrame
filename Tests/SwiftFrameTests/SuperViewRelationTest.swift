//  Created by Dmitriy Verennik on 22.03.2022.
//

import XCTest

final class SuperViewRelationTest: BaseTest {
    
    let insets: UIEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
    
    func testLeftToRightRelation() {
        
        let etalonDimensions = CGRect(x: 0, y: 0, width: 800, height: 800)
        firstView.frame {
            $0.top().bottom()
            $0.left().right()
        }
        XCTAssertEqual(firstView.frame, etalonDimensions)
    }
    
    func testLayoutWithInsets() {
        
        let etalonDimensions = CGRect(x: 15, y: 15, width: 770, height: 770)
        firstView.frame {
            $0.top(inset: self.insets.top)
            $0.left(inset: self.insets.left)
            $0.right(inset: self.insets.right)
            $0.bottom(inset: self.insets.bottom)
        }
        XCTAssertEqual(firstView.frame, etalonDimensions)
    }
    
    func testRightToLeftRelation() {
        
        let etalonDimensions = CGRect(x: 0, y: 0, width: 800, height: 800)
        firstView.frame {
            $0.top().bottom()
            $0.right().left()
        }
        XCTAssertEqual(firstView.frame, etalonDimensions)
    }
    
    func testBottomToTopRelation() {
        
        let etalonDimensions = CGRect(x: 0, y: 0, width: 800, height: 800)
        firstView.frame {
            $0.bottom().top()
            $0.left().right()
        }
        XCTAssertEqual(firstView.frame, etalonDimensions)
    }
    
    func testLeftToRightWithInsetsRelation() {
        
        let etalonDimensions = CGRect(x: 15, y: 0, width: 770, height: 800)
        firstView.frame {
            $0.top()
            $0.bottom()
            $0.left(inset: insets.left)
            $0.right(inset: insets.right)
        }
        XCTAssertEqual(firstView.frame, etalonDimensions)
    }
    
    func testRightToLeftWithInsetsRelation() {
        
        let etalonDimensions = CGRect(x: 15, y: 0, width: 770, height: 800)
        firstView.frame {
            $0.top()
            $0.bottom()
            $0.right(inset: insets.right)
            $0.left(inset: insets.left)
        }
        XCTAssertEqual(firstView.frame, etalonDimensions)
    }
    
    func testBottomToTopWithInsetsRelation() {
        
        let etalonDimensions = CGRect(x: 0, y: 15, width: 800, height: 770)
        firstView.frame {
            $0.bottom(inset: insets.bottom)
            $0.top(inset: insets.top)
            $0.left().right()
        }
        XCTAssertEqual(firstView.frame, etalonDimensions)
    }
}
