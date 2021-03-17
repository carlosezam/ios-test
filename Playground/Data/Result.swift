//
//  Result.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import Foundation

enum Result<T> {
  case Success(T)
  case Failure(Error)
}
