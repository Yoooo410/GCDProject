//
//  ViewController.swift
//  GCDProject
//
//  Created by Yoshito Komiya on 2017/07/10.
//  Copyright © 2017 Yoshito Komiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        simpleQueues()
        queuesWithQoS()
//        concurrentQueues()
        
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        simpleQueues()
//        queuesWithQoS()
//        concurrentQueues()
//        if let queue = inactiveQueue {
//            queue.activate()
//        }
//        queueWithDelay()
        
//    }
    

    
    
    func simpleQueues() {
        let queue = DispatchQueue(label: "com.derrick.myqueue")
        
        queue.async {
            for i in 0..<10 {
            print("😀", i)
            }
            
            for i in 100..<110 {
                print("😆", i)
            }
        }
        
    }
    
    
    
    
    func queuesWithQoS() {
        let queue1 = DispatchQueue(label: "com.derrick.myqueue1", qos: .userInteractive)
        let queue2 = DispatchQueue(label: "com.derrick.myqueue2", qos: .utility)

        queue1.async {
            for i in 0..<10 {
                print("😀", i)
            }
        }
        
        queue2.async {
            for i in 100..<110 {
                print("😆", i)
            }
        }
        
        for i in 1000..<1010 {
            print("😞", i)
        }
    }
    
    
    
    
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        let anotherQueue = DispatchQueue(label: "com.derrick.anotherqueue", qos: .utility, attributes: .concurrent)
        
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                print("😀", i)
            }
        }
        anotherQueue.async {
            for i in 100..<110 {
                print("😆", i)
            }
        }
        anotherQueue.async {
            for i in 1000..<1010 {
                print("😞", i)
            }
        }
    }
    
    
    
    
    func queueWithDelay() {
        let delayQueue = DispatchQueue(label: "com.derrick.delayqueue", qos: .userInteractive)

        print(Date())
        
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
    }
    
    
    
    
    func fetchImage() {
        let imageURL: URL = URL(string: "https://toucharcade.com/wp-content/uploads/2015/06/fujiyoshida-and-mount-fuji-japan.jpg")!
        (URLSession(configuration: .default).dataTask(with: imageURL) { (data, response, error) in
            if let data = data {
                print("Did not ")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
    
    
    
    
    func useWorkItem() {
        var value = 10
        let workItem = DispatchWorkItem {
            value += 10
        }
        workItem.perform()
        print(value)
        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: workItem)
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


 
}

