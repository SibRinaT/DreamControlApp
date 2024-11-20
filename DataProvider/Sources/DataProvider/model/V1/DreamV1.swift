import Foundation
import SwiftData


public typealias Dream = SchemaV1.Dream

extension SchemaV1 {
    @Model
    public final class Dream: Sendable {
        public let id: UUID = UUID()
        
        public init(id: UUID = UUID()) {
            self.id = id
        }
    }
}

//extension Dream {
//    public static func dreamsPredicate() -> Predicate<Dream> {
//        return #Predicate<Dream> {
//            true
//        }
//    }
//}
