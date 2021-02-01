//
//  tailerViewController.swift
//  Flix
//
//  Created by zhong zheng on 2/1/21.
//  Copyright © 2021 ZHONG ZHENG. All rights reserved.
//

import UIKit
import WebKit

class tailerViewController: UIViewController {
    
    @IBOutlet weak var goBack: UIButton!
    
    @IBOutlet weak var webView: WKWebView!
    
    var videoURL: URL! = nil
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(goBack)
        view.addSubview(webView)
        goBack.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        webView.load(URLRequest(url: videoURL))
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func buttonAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
