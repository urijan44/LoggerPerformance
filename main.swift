//
//  main.swift
//  LoggerPerformance
//
//  Created by hoseung Lee on 12/29/23.
//

import Foundation
import os
import os.log

let socketText = """
{
    "type": "data",
    "subtype": "tk",
    "content": {
        "m": "C0100",
        "c": "C0661",
        "k": "MID",
        "o": "401",
        "e": "413",
        "h": "424",
        "l": "384",
        "u": "1476091760.87133346",
        "v": "3633384.92734215",
        "r": "3.25",
        "a": "13",
        "w": "85.95",
        "f": "400",
        "u24": "1673033859.14572522",
        "v24": "4121084.64384168"
    }
}
"""

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

let arguments = CommandLine.arguments
var loggerType: LoggerClass = .print
if let loggerIndex = arguments.firstIndex(of: "--logger"), arguments.count > loggerIndex + 1 {
  loggerType = LoggerClass(string: arguments[loggerIndex + 1])
}
let log = OSLog(subsystem: Bundle.module.bundleIdentifier!, category: "Log")
let logger = Logger(log)

let printTimer = Timer(timeInterval: 1 / 50, repeats: true) { _ in
  DispatchQueue.global().async {
    print(socketText)
  }
}

let oslogTimer = Timer(timeInterval: 1 / 50, repeats: true) { _ in
  DispatchQueue.global().async {
    os_log(log: log, "\(socketText)")
  }
}

let loggerTimer = Timer(timeInterval: 1 / 50, repeats: true) { _ in
  DispatchQueue.global().async {
    logger.log("\(socketText)")
  }
}



let exitTask = DispatchWorkItem {
  print("exit!")
  exit(0)
}


DispatchQueue.global().asyncAfter(deadline: .now() + 20, execute: exitTask)
let timer: Timer = {
  switch loggerType {
    case .print:
      return printTimer
    case .oslog:
      return oslogTimer
    case .logger:
      return loggerTimer
  }
}()
print("start!: \(loggerType)")
RunLoop.current.add(timer, forMode: .default)

RunLoop.main.run()

