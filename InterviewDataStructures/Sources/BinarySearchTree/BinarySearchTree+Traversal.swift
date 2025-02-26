//
//  BinarySearchTree+Traversal.swift
//  SwiftInterviewDataStructures
//
//  Created by Jon Schneider on 2/25/25.
//

import Foundation

public extension BinarySearchTree {
    enum TraversalType {
        case inorder
        case preorder
        case postorder
        case breadthFirst
    }

    static func traverse(_ tree: Node, _ type: TraversalType = .inorder, forEach: (Value) -> Void) {
        switch type {
        case .inorder:
            inorderTraversal(of: tree, forEach: forEach)
        case .preorder:
            preorderTraversal(of: tree, forEach: forEach)
        case .postorder:
            postorderTraversal(of: tree, forEach: forEach)
        case .breadthFirst:
            breadthFirstTraversal(of: tree, forEach: forEach)
        }
    }

    // MARK: Private

    static private func inorderTraversal(of tree: Node, forEach: (Value) -> Void) {
        tree.left.map({ inorderTraversal(of: $0, forEach: forEach) })
        forEach(tree.value)
        tree.right.map({ inorderTraversal(of: $0, forEach: forEach) })
    }

    static private func preorderTraversal(of tree: Node, forEach: (Value) -> Void) {
        forEach(tree.value)
        tree.left.map({ preorderTraversal(of: $0, forEach: forEach) })
        tree.right.map({ preorderTraversal(of: $0, forEach: forEach) })
    }

    static private func postorderTraversal(of tree: Node, forEach: (Value) -> Void) {
        tree.left.map({ postorderTraversal(of: $0, forEach: forEach) })
        tree.right.map({ postorderTraversal(of: $0, forEach: forEach) })
        forEach(tree.value)
    }

    static private func breadthFirstTraversal(of tree: Node, forEach: (Value) -> Void) {
        // An array is not a good queue asymptotically, but it is acceptable until I write a dedicated queue
        var queue = [tree]

        while !queue.isEmpty {
            let node = queue.removeFirst()

            node.left.map({ queue.append($0) })
            node.right.map({ queue.append($0) })

            forEach(node.value)
        }
    }
}
