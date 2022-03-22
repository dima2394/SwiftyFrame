import XCTest

final class SizeTest: BaseTest {
    
    func testSize() {
        firstView.configureFrame {
            $0.size(width: 200, height: 200)
        }
        XCTAssertEqual(firstView.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    func testSquareSize() {
        firstView.configureFrame {
            $0.squareSize(200)
        }
        XCTAssertEqual(firstView.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }
}
