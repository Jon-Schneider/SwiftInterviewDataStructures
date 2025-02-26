//
//  Tree.swift
//  SwiftInterviewDataStructures
//
//  Created by Jon Schneider on 2/25/25.
//

import Foundation 

// Enum namespacing with generic definition for enclosed Value
public enum BinarySearchTree<Value: Comparable> {
    // I would prefer to define Nodes as structs and use inout functions to mutate the structure of the tree so the tree can be a value type but value types cannot recursively use themselves
    // There are workarounds, but making Node a class is cleaner
    public class Node {
        public let value: Value
        public var parent: Node?
        public var left: Node?
        public var right: Node?

        public init(value: Value, parent: Node? = nil, left: Node? = nil, right: Node? = nil) {
            self.value = value
            self.left = left
            self.right = right
        }
    }
}
