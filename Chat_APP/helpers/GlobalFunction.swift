//
//  GlobalFunction.swift
//  Chat_APP
//
//  Created by Nasser Mohamed on 24/09/2022.
//

import Foundation
func fileNameFrom(fileUrl:String)->String{
    let name=fileUrl.components(separatedBy: "_").last
    let name1=name?.components(separatedBy: "?").first
    let name2=name1?.components(separatedBy: ".").first
    return name2!
}

func timeElapse(_ date:Date)->String{
    let second=Date().timeIntervalSince(date)
    var elapse=""
    if second<60{
        elapse="Just now"
    }
    else if second<60*60{
        let minutes=Int(second/60)
        let minText=minutes>1 ? "mins":"min"
        elapse="\(minutes) \(minText)"
    }
    else if second < 24*60*60{
        let hours=Int(second/(60*60))
        let hourText = hours > 1 ? "hours":"hour"
        elapse="\(hours) \(hourText)"
    }else{
        elapse="\(date.longDate())"
    }
    return elapse
}
