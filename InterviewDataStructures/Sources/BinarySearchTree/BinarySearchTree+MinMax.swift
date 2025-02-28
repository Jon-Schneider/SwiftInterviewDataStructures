//
//  BinarySearchTree+MinMax.swift
//
//
//  Created by Jon Schneider on 2/26/25.
//

import Foundation

extension BinarySearchTree {
    static func min(in tree: Node) -> Value {
        guard let leftNode = tree.left else {
            return tree.value
        }

        return min(in: leftNode)
    }

    static func max(in tree: Node) -> Value {
        guard let rightNode = tree.right else {
            return tree.value
        }

        return max(in: rightNode)
    }
}
