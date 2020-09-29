//
//  ClosureAliases.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 21/11/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public typealias Runnable = () -> Void
public typealias Consumer<T> = (T) -> Void
public typealias Producer<T> = () -> T

public typealias Filter<T> = (T) -> Bool
public typealias Mapper<T, V> = (T) -> V
public typealias Sorter<T> = (T, T) -> Bool

public typealias Predicate<T> = (T) -> Bool
