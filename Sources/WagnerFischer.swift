//
//  WagnerFischer.swift
//  WagnerFischer
//
//  Created by Caleb Davenport on 2/22/16.
//  Copyright © 2016 Caleb Davenport. All rights reserved.
//

/// A single edit step.
public enum EditStep<Value> {
    case Insert(location: Int, value: Value)
    case Substitute(location: Int, value: Value)
    case Delete(location: Int)

    public var location: Int {
        switch self {
        case .Insert(let location, _): return location
        case .Substitute(let location, _): return location
        case .Delete(let location): return location
        }
    }
}

extension EditStep: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .Insert(let index, let value):
            return "Insert(\(index), \(value))"
        case .Substitute(let index, let value):
            return "Substitute(\(index), \(value))"
        case .Delete(let index):
            return "Delete(\(index))"
        }
    }
}

public func editSteps<T>(source: [T], _ destination: [T], compare: (T, T) -> Bool) -> [EditStep<T>] {

    // Return all insertions if the source is empty.
    if source.isEmpty {
        return destination.enumerate().map({ index, value in
            .Insert(index, value)
        })
    }

    // Return all deletions if the destination is empty.
    if destination.isEmpty {
        return source.enumerate().map({ index, _ in
            .Delete(index)
        })
    }

    var matrix = Matrix<[EditStep<T>]>(
        rows: source.count + 1,
        columns: destination.count + 1,
        repeatedValue: [])

    for i in 1...source.count {
        matrix[i, 0] = (0...i).map({ .Delete(location: $0) })
    }

    for j in 1...destination.count {
        matrix[0, j] = (1...j).lazy.map({ $0 - 1 }).map({
            let destinationValue = destination[$0]
            return EditStep.Insert(location: $0, value: destinationValue)
        })
    }

    for i in 1...source.count {
        for j in 1...destination.count {
            let destinationValue = destination[j - 1]
            if compare(source[i - 1], destinationValue) {
                matrix[i, j] = matrix[i - 1, j - 1]
            }
            else {
                let a = matrix[i - 1, j] + CollectionOfOne(.Delete(location: i - 1))
                let b = matrix[i, j - 1] + CollectionOfOne(.Insert(location: j - 1, value: destinationValue))
                let c = matrix[i - 1, j - 1] + CollectionOfOne(.Substitute(location: j - 1, value: destinationValue))
                matrix[i, j] = shortest(a, b, c)
            }
        }
    }

    return matrix[source.count, destination.count]
}

public func editSteps<T: Equatable>(source: [T], _ destination: [T]) -> [EditStep<T>] {
    return editSteps(source, destination, compare: ==)
}

public func editSteps(source: String, _ destination: String) -> [EditStep<Character>] {
    return editSteps(Array(source.characters), Array(destination.characters))
}

public func editDistance<T>(source: [T], _ destination: [T], compare: (T, T) -> Bool) -> Int {
    return editSteps(source, destination, compare: compare).count
}

public func editDistance<T: Equatable>(source: [T], _ destination: [T]) -> Int {
    return editSteps(source, destination).count
}

public func editDistance(source: String, _ destination: String) -> Int {
    return editSteps(source, destination).count
}

public func applyEditSteps<T>(source: [T], editSteps: [EditStep<T>]) -> [T]? {
    var destination = source

    for step in editSteps {
        switch step {
        case .Insert(let location, let value):
            guard location <= destination.count else { return nil }
            destination.insert(value, atIndex: location)
        case .Delete(let location):
            guard location < destination.count else { return nil }
            destination.removeAtIndex(location)
        case .Substitute(let location, let value):
            guard location < destination.count else { return nil }
            destination.removeAtIndex(location)
            destination.insert(value, atIndex: location)
        }
    }

    return destination
}

public func applyEditSteps(source: String, editSteps: [EditStep<Character>]) -> String? {
    guard let characters = applyEditSteps(Array(source.characters), editSteps: editSteps) else { return nil }
    return String(characters)
}
