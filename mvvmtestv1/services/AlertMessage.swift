//
//  AlertMessage.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 13.02.2021.
//

import Foundation

class AlertMessage {
    
    init(title:String,body:String) {
        self.title = title
        self.body = body
    }
    
    
    var title = Constants.defaultAlertTitle
    var body = Constants.defaultAlertMessage

}
