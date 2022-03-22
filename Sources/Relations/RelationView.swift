//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

final public class RelationView<Relation> {
    
    unowned let view: UIView
    let relationType: Relation
    
    init(view: UIView, relationType: Relation) {
        self.view = view
        self.relationType = relationType
    }
}
