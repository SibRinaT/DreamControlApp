import Foundation
import SwiftData


public typealias Dream = SchemaV1.Dream

extension SchemaV1 {
    @Model
    public final class Dream: Sendable {
        public let id: UUID = UUID()
        public let name = ""
        public let image = ""
        public var stories: [DreamStory]?
        
        public init(id: UUID = UUID(), name: String, image: String, stories: [DreamStory]? = nil) {
            self.id = id
            self.name = name
            self.image = image
            self.stories = stories
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
