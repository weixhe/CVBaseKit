//
//  DeviceDemo.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/18.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class DeviceDemo: NSObject, DemoConverable {
    var text: String {
        return  """
        设备型号：\(CVDevice.getDeviceModel())
        设备名称：\(CVDevice.getDeviceName())
        IP地址：\(CVDevice.getIPAddresses())
        WIFI名：\(CVDevice.getWifiName())
        MAC地址：\(CVDevice.getWifiMacAddress())
        系统版本号：\(CVDevice.sysVersion)
        系统名称：\(CVDevice.sysName)
        唯一标识：\(CVDevice.getUUID())
        """
    }
}
