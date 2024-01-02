//
//  LoggerPerformance.swift
//  LoggerPerformance
//
//  Created by henry.lee on 1/2/24.
//

import Foundation
import os
import os.log
import ArgumentParser

struct loggerperformance: ParsableCommand {
  
  @Argument(help: "select to logger type, [print, oslog, logger]")
  var type: String
  
  @Option(name: .shortAndLong, help: "The Interval of log by 1 seconds if you write '30' it will log 30/s")
  var timeInterval: TimeInterval = 50
  
  @Option(name: .shortAndLong, help: "program run time")
  var runTime: TimeInterval = 20
  
  private var timeIntervalPerSeconds: TimeInterval {
    get {
      1 / timeInterval
    }
  }
    
  mutating func run() throws {
    
    let log = OSLog(subsystem: Bundle.module.bundleIdentifier!, category: "Log")
    lazy var logger = Logger(log)
    
    
    let exitTask = DispatchWorkItem {
      print("exit!")
      loggerperformance.exit()
    }
    
    let printTimer = Timer(timeInterval: timeIntervalPerSeconds, repeats: true) { _ in
      DispatchQueue.global().async {
        print(socketText)
      }
    }
    
    let oslogTimer = Timer(timeInterval: timeIntervalPerSeconds, repeats: true) { _ in
      DispatchQueue.global().async {
        os_log(log: log, "\(socketText)")
      }
    }
    
    let loggerTimer = Timer(timeInterval: timeIntervalPerSeconds, repeats: true) { _ in
      DispatchQueue.global().async {
        logger.log("\(socketText)")
      }
    }
    
    let loggerType = {
      LoggerClass(string: type)
    }()
    
    DispatchQueue.global().asyncAfter(deadline: .now() + runTime, execute: exitTask)
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
  }
}
