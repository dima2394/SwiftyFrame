//
//  Created by Dmitriy Verennik on 23.03.2022.
//

import UIKit

public extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func widthThatFits(_ width: CGFloat) -> CGFloat {
        return sizeThatFits(CGSize(width: width, height: bounds.height)).width
    }
    
    func heightThatFits(_ height: CGFloat) -> CGFloat {
        return sizeThatFits(CGSize(width: bounds.width, height: height)).height
    }
}
