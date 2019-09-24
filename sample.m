//
//  ding.swift
//  Dprint
//
//  Created by lappy on 20/09/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UIKit


@objc(Bulb)
class Bulb: NSObject {
  
  
  enum Result {
      case success
      case errorOpenPort
      case errorBeginCheckedBlock
      case errorEndCheckedBlock
      case errorWritePort
      case errorReadPort
      case errorUnknown
  }
  
  @objc static var isOn = false
  
  @objc static func requiresMainQueueSetup() -> Bool {  return true}
  
  @objc func turnOn() {
    Bulb.isOn = true
    
  }
  
  @objc func turnOff() {
    Bulb.isOn = false
  }
  
  @objc func getPrinters() -> Array<PortInfo> {
    var searchPrinterResult: [PortInfo]? = nil
    do {
        searchPrinterResult = try SMPort.searchPrinter(target: "BT:") as? [PortInfo]
    }
    catch {
        // do nothing
    }
    print(searchPrinterResult);
    return searchPrinterResult!
  }
  
  @objc func connectPrinter() {
    var smPort: SMPort
    
    do {
      smPort = try SMPort.getPort("BT:mPOP", ";", 10000)
      defer {
        // Close port
        SMPort.release(smPort)
      }
      //var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
      //var isStarted: UInt32;
      // Start to check the completion of printing
      //try smPort.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
      //print(isStarted);
      //let v = "Amaresh is eating food and palaying games laptop air mac nothing we are testing the printer with string to uint8 so now it should get this text ";
      //var command: [UInt8] = [0x41, 0x42, 0x43, 0x0a, 0x1b, 0x7a, 0x00, 0x1b, 0x64, 0x02]
      //let emulation: StarIoExtEmulation = StarIoExtEmulation.starPRNT;
      //let otherData: Data = "Hello World.".data(using: String.Encoding.ascii)!
      
      //let bytes: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e]
      
      //let length: UInt = UInt(bytes.count)
      
      let builder: ISCBBuilder = StarIoExt.createCommandBuilder(StarIoExtEmulation.starPRNT)
      
      /*builder.beginDocument()
      
      builder.append(otherData)
      builder.appendByte(0x0a)
      
      builder.appendBytes(bytes, length: length)
      builder.appendByte(0x0a)
      
      builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
      
      builder.endDocument()*/
      let encoding: String.Encoding
      
     encoding = String.Encoding.utf8
      builder.beginDocument()
      builder.append(SCBCodePageType.UTF8)
      
      builder.append(SCBInternationalType.japan)
              
              builder.appendCharacterSpace(0)
              
              builder.appendAlignment(SCBAlignmentPosition.center)
              
              builder.append((
                  "Welks Merchant\n" +
                  "123 Star Road\n" +
                  "City, State 12345\n" +
                  "\n").data(using: encoding))
              
              builder.appendAlignment(SCBAlignmentPosition.left)
              
              builder.append((
                  "Date:MM/DD/YYYY    Time:HH:MM PM\n" +
                  "--------------------------------\n" +
                  "\n").data(using: encoding))
              
              builder.appendData(withEmphasis: "SALE\n".data(using: encoding))
              
              builder.append((
                  "SKU         Description    Total\n" +
                  "300678566   PLAIN T-SHIRT  10.99\n" +
                  "300692003   BLACK DENIM    29.99\n" +
                  "300651148   BLUE DENIM     29.99\n" +
                  "300642980   STRIPED DRESS  49.99\n" +
                  "300638471   BLACK BOOTS    35.99\n" +
                  "\n" +
                  "Subtotal                  156.95\n" +
                  "Tax                         0.00\n" +
                  "--------------------------------\n").data(using: encoding))
              
              builder.append("Total     ".data(using: encoding))
              
              builder.appendData(withMultiple: "   $156.95\n".data(using: encoding), width: 2, height: 2)
              
              builder.append((
                  "--------------------------------\n" +
                  "\n" +
                  "Charge\n" +
                  "159.95\n" +
                  "Visa XXXX-XXXX-XXXX-0123\n" +
                  "\n").data(using: encoding))
              
              builder.appendData(withInvert: "Refunds and Exchanges\n".data(using: encoding))
              
              builder.append("Within ".data(using: encoding))
              
              builder.appendData(withUnderLine: "30 days".data(using: encoding))
              
              builder.append(" with receipt\n".data(using: encoding))
              
              builder.append((
                  "And tags attached\n" +
                  "\n").data(using: encoding))
              
              builder.appendAlignment(SCBAlignmentPosition.center)
              
      //      builder.appendBarcodeData("{BStar.".data(using: encoding),              symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
              builder.appendBarcodeData("{BStar.".data(using: String.Encoding.ascii), symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
      builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
      
      builder.endDocument()
      let ding = builder.commands.copy() as? Data
      
      let co: Bool = sendCommands(ding, port: smPort)
      print("print "+String(co))
      
      /*let commands = builder.commands.copy();
      
      var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
      
      commands.copyBytes(to: &commandsArray, count: commands.count)

      var total: UInt32 = 0
      while total < UInt32(command.count) {
        var written: UInt32 = 0
        // Send print data
        try smPort.write(writeBuffer: command, offset: total, size: UInt32(command.count) - total, numberOfBytesWritten: &written)
        total += written
        
      }
      //var isFinished: UInt32;
      // Stop to check the completion of printing
      try smPort.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)*/
      
      //print(isFinished)
    } catch {
      print("Error ");
    }
    //print(smPort);
  }
  
  @objc func sendCommands(_ commands: Data!, port: SMPort!) -> Bool {
      var result: Result = .errorOpenPort
      var code: Int = SMStarIOResultCodeFailedError
      
      var commandsArray: [UInt8] = [UInt8](repeating: 0, count: commands.count)
      
      commands.copyBytes(to: &commandsArray, count: commands.count)
      
      while true {
          do {
              if port == nil {
                  break
              }
              
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
              
              result = .errorBeginCheckedBlock
              
              try port.beginCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
              
              if printerStatus.offline == 1 {
                  print("Printer is offline")
                  break
              }
              
              result = .errorWritePort
              
              //let startDate: Date = Date()
              
              var total: UInt32 = 0
              
              while total < UInt32(commands.count) {
                  var written: UInt32 = 0
                  
                  try port.write(writeBuffer: commandsArray, offset: total, size: UInt32(commands.count) - total, numberOfBytesWritten: &written)
                  
                  total += written
                  
              }
              
              if total < UInt32(commands.count) {
                print("No commands")
                  break
              }
              
              port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
              
              result = .errorEndCheckedBlock
              
              try port.endCheckedBlock(starPrinterStatus: &printerStatus, level: 2)
              
              if printerStatus.offline == 1 {
                print("Printer is offline")
                  break
              }
              
              result = .success
              code = SMStarIOResultCodeSuccess
              
              break
          }
          catch let error as NSError {
              code = error.code
              break
          }
      }
      return result == .success
  }
  
}