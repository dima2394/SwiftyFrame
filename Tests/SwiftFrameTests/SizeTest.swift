import XCTest

final class SizeTest: BaseTest {
    
    func testSize() {
        firstView.frame {
            $0.size(width: 200, height: 200)
        }
        XCTAssertEqual(firstView.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    func testSquareSize() {
        firstView.frame {
            $0.squareSize(200)
        }
        XCTAssertEqual(firstView.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    func testEqualSize() {
        firstView.frame { $0.squareSize(200) }
        secondView.frame { $0.size(equalTo: firstView) }
        XCTAssertEqual(firstView.bounds.size, secondView.bounds.size)
    }
}
