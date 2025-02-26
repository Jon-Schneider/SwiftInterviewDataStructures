//
//  BinarySearchTreeTests.swift
//  
//
//  Created by Jon Schneider on 2/26/25.
//

import InterviewDataStructures
import XCTest

final class BinarySearchTreeTests: XCTestCase {
    // We need traversal to test the structure of our BST, so we can't really test them independently - if the test fails we know the issue is with one or the other
    func testBinarySearchTreeStructureAndTraversal() throws {

        //        100
        //       /   \
        //     90    200
        //           /   \
        //        110    220
        let root = BinarySearchTree<Int>.Node(value: 100)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)

        var inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 100, 110, 200, 220])

        var preorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .preorder) {
            preorderTraversalValues.append($0)
        }
        XCTAssertEqual(preorderTraversalValues, [100, 90, 200, 110, 220])

        var postOrderTraveralValues = [Int]()
        BinarySearchTree.traverse(root, .postorder) {
            postOrderTraveralValues.append($0)
        }
        XCTAssertEqual(postOrderTraveralValues, [90, 110, 220, 200, 100])
    }

    func testBinarySearchTreeDeletion() throws {

        //        100
        //       /   \
        //     90    200
        //           /   \
        //        110    220
        var root = BinarySearchTree<Int>.Node(value: 100)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)

        root = try XCTUnwrap(BinarySearchTree.delete(220, from: root))

        var inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 100, 110, 200])

        root = try XCTUnwrap(BinarySearchTree.delete(100, from: root))
        inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 110, 200])

        root = try XCTUnwrap(BinarySearchTree.delete(90, from: root))
        inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [110, 200])
    }

    func testBinarySearchTreeDuplicatesAreNotInserted() throws {
        //        100
        //       /   \
        //     90    200
        //           /   \
        //        110    220
        let root = BinarySearchTree<Int>.Node(value: 100)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)

        // Try reinserting every node, none should be duplicated in the tree
        BinarySearchTree.insert(100, in: root)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)

        var inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 100, 110, 200, 220])
    }

    func testBinarySearchTreeSingleNodeDeletion() {
        // Deleting a root node with no children should return nil for the new root node
        let rootValue = 100
        let root = BinarySearchTree<Int>.Node(value: rootValue)
        XCTAssertNil(BinarySearchTree.delete(rootValue, from: root))
    }
}
