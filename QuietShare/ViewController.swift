//
//  ViewController.swift
//  QuietShare
//
//  Created by Winster Thuruthippillil JOSE on 19/03/17.
//  Copyright © 2017 Winster Thuruthippillil JOSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func transmit(_ sender: Any) {
    
    let txConf: QMTransmitterConfig = QMTransmitterConfig(key: "ultrasonic");
    let tx: QMFrameTransmitter = QMFrameTransmitter(config:txConf);
    let frame_str = "winster@quiet";
    let data = frame_str.data(using: .utf8);
    tx.send(data);
    CFRunLoopRun();
    tx.close();
    
  }

  @IBAction func scan(_ sender: Any) {
    AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
      if granted {
        let rxConf: QMReceiverConfig = QMReceiverConfig(key:"ultrasonic");
        let rx = QMFrameReceiver(config: rxConf);
        rx?.setReceiveCallback(receiveCallback);
      } else {
        print("Permission to record not granted")
      }
    })
  }
  
  func receiveCallback(frame: NSData) {
    print("inside callback");
  }
  
}

