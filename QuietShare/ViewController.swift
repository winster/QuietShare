//
//  ViewController.swift
//  QuietShare
//
//  Created by Winster Thuruthippillil JOSE on 19/03/17.
//  Copyright © 2017 Winster Thuruthippillil JOSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  var tx: QMFrameTransmitter = {
    let txConf: QMTransmitterConfig = QMTransmitterConfig(key: "ultrasonic-experimental");
    let tx: QMFrameTransmitter = QMFrameTransmitter(config:txConf);
    return tx;
  }()
  var rx: QMFrameReceiver?;

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func transmit(_ sender: Any) {
    let frame_str = "winster@quiet";
    let data = frame_str.data(using: .utf8);
    self.tx.send(data);
  }

  @IBAction func scan(_ sender: Any) {
    AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
      if granted {
        if self.rx == nil {
          let rxConf: QMReceiverConfig = QMReceiverConfig(key:"ultrasonic-experimental");
          self.rx = QMFrameReceiver(config: rxConf);
          self.rx?.setReceiveCallback(self.receiveCallback);
        }
      } else {
        print("Permission to record not granted")
      }
    })
  }

    
 func receiveCallback(frame: Data?) {
    let msg = String(data: frame ?? Data(), encoding: String.Encoding.utf8) ?? "data could not be decoded";
    print(msg)
  }
  
}


