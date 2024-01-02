//
//  LoggerClass.swift
//  LoggerPerformance
//
//  Created by henry.lee on 1/2/24.
//

enum LoggerClass {
  case print
  case oslog
  case logger
  
  init(string: String) {
    switch string {
      case "print":
        self = .print
      case "oslog":
        self = .oslog
      case "logger":
        self = .logger
      default:
        self = .print
    }
  }
}
