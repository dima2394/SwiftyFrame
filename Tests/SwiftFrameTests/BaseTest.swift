//  Created by Dmitriy Verennik on 22.03.2022.
//

import XCTest
@testable import SwiftyFrame

class BaseTest: XCTestCase {
    
    var contentView = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
    var firstView = UIView()
    var secondView = UIView()
    
    override func setUp() {
        super.setUp()
        contentView.addSubviews(firstView,
                                secondView)
    }
    
    override func tearDown() {
        super.tearDown()
        firstView.removeFromSuperview()
        secondView.removeFromSuperview()
    }
}
