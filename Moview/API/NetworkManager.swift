//
//  NetworkManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation
import SystemConfiguration

class NetworkManager {
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, ServicesConstants.URL().getMainDomain())
    
    init(){
        guard let r = reachability else {
            return
        }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(r, &flags)
    }
    
    func validateConnection() -> Bool{
        guard let r = reachability else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(r, &flags)
        return self.isNetworkReachable(with: flags)
        
    }
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) ||
                                        flags.contains(.connectionOnTraffic)
        let canConnectWithoutInteraction = canConnectAutomatically &&
                                            !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutInteraction)
    }
    
   
}
