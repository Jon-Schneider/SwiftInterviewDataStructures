//
//  BinarySearchTree+Mutation.swift
//  SwiftInterviewDataStructures
//
//  Created by Jon Schneider on 2/25/25.
//

import Foundation

public extension BinarySearchTree {

    // MARK: Instance Implementation

    func insert(_ value: Value) {
        guard let root else {
            return
        }

        BinarySearchTree.insert(value, in: root)
    }

    func delete(_ value: Value) {
        guard let root else {
            return
        }

        self.root = BinarySearchTree.delete(value, from: root)
    }

    // MARK: Static implementation

    static func insert(_ value: Value, in tree: Node) {
        // Don't insert duplicates
        // This guard isn't necessary but I added the base case to make this explicit
        if tree.value == value {
            return
        }

        if value < tree.value {
            if let leftNode = tree.left {
                BinarySearchTree.insert(value, in: leftNode)
            } else {
                tree.left = Node.init(value: value)
            }
        } else if value > tree.value {
            if let rightNode = tree.right {
                BinarySearchTree.insert(value, in: rightNode)
            } else {
                tree.right = Node.init(value: value)
            }
        }
    }

    /// Deletes passed value from the passed tree
    /// - Parameters:
    ///   - value: The value to delete from teh tree
    ///   - tree: Root node of the tree to delete the value from
    /// - Returns: The new root node of the tree passed to 'tree'
    @discardableResult static func delete(_ value: Value, from tree: Node) -> Node? {
        // If the root of the tree contains the value then replace it with the appropriate node in its subtree
        if tree.value == value {

            // If there is only a left subtree then replace the node to be deleted with the left subtree root
            if let leftNode = tree.left, tree.right == nil {
                leftNode.parent = tree.parent
                leftNode.right = tree.right
                return leftNode
            }

            // If there is only a right subtree then replace the node to be deleted with the right subtree root
            else if let rightNode = tree.right, tree.left == nil {
                rightNode.parent = tree.parent
                rightNode.left = tree.left
                return rightNode
            }

            // If there is a right subtree, replace the node to delete with the minimum node from the right subtree
            else if let leftNode = tree.left, let rightNode = tree.right {
                let rightSubtreeMinValue = BinarySearchTree.min(in: rightNode)

                let promotedNode = Node(value: rightSubtreeMinValue)
                promotedNode.left = leftNode
                promotedNode.right = BinarySearchTree.delete(rightSubtreeMinValue, from: rightNode)
                promotedNode.parent = tree.parent

                return promotedNode
            }

            // If the node to delete has no children then return nil to represent an empty tree replacing it
            else {
                return nil
            }
        } else if let leftNode = tree.left, value < tree.value {
            tree.left = delete(value, from: leftNode)
        } else if let rightNode = tree.right {
            tree.right = delete(value, from: rightNode)
        }

        return tree
    }
}
