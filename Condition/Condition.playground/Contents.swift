//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

let condition = NSCondition()
var available = false

class WriterThread: Thread {
    
    override func main() {
        print("WriterThread enter")
        condition.lock()
        available = true
        condition.signal()
        condition.unlock()
        print("WriterThread exit")
    }
    
}

class PrinterThread: Thread {
    
    override func main() {
        print("PrinterThread enter")
        condition.lock()
        while !available { condition.wait() }
        available = false
        condition.unlock()
        print("PrinterThread exit")
    }
    
}

let writer = WriterThread()
let printer = PrinterThread()

writer.start()
printer.start()
