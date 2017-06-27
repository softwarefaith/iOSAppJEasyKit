//
//  MLDeviceInfoCollection.m
//  DeviceInfo
//
//  Created by 蔡杰 on 2017/6/26.
//  Copyright © 2017年 Allan. All rights reserved.
//

#import "MLDeviceInfoCollection.h"
#import "MLDeviceInfo.h"

@interface MLDeviceInfoCollection ()

@property (nonatomic, readwrite) NSTimeInterval currentTimestamp;
@property (nonatomic, copy, readwrite) NSString * timestampString;
@property (nonatomic, copy, readwrite) NSString * appDisplayName;
@property (nonatomic, copy, readwrite) NSString * appVersion;
@property (nonatomic, copy, readwrite) NSString * systemVersion;
@property (nonatomic, copy, readwrite) NSString * systemName;
@property (nonatomic, copy, readwrite) NSString * preferredLanguage;
@property (nonatomic, copy, readwrite) NSString * phoneModel;
@property (nonatomic, copy, readwrite) NSString * deviceName;
@property (nonatomic, readwrite) CGFloat batteryLevel;
@property (nonatomic, readwrite) long long totalMemorySize;
@property (nonatomic, readwrite) long long availableMemorySize;
@property (nonatomic, readwrite) long long totalDiskSize;
@property (nonatomic, readwrite) long long availableDiskSize;
@property (nonatomic, copy, readwrite) NSString * idfa;
@property (nonatomic, copy, readwrite) NSString * idfv;
@property (nonatomic, copy, readwrite) NSString * countryCode;
@property (nonatomic, copy, readwrite) NSString * telephonyCarrier;
@property (nonatomic, copy, readwrite) NSString * mobileCountryCode;
@property (nonatomic, copy, readwrite) NSString * mobileNetworkCode;
@property (nonatomic, copy, readwrite) NSString * ipAddress;
@property (nonatomic, copy, readwrite) NSString * wifiIpAddress;
@property (nonatomic, copy, readwrite) NSString * wifiName;
@property (nonatomic, readwrite) BOOL jailbroken;
@property (nonatomic, readwrite) CGFloat brightness;
@property (nonatomic, copy, readwrite) NSString * dns;
@property (nonatomic, copy, readwrite) NSString * networkType;

@end

@implementation MLDeviceInfoCollection

+ (MLDeviceInfoCollection *)shareDeviceInfoCollection{

    static MLDeviceInfoCollection * deviceInfo = nil;
    
    static dispatch_once_t token ;
    dispatch_once(&token,^{
        deviceInfo = [[self alloc]init];
    
    });
    return deviceInfo;
}

- (instancetype)init{

    if (self = [super init]) {
        _currentTimestamp = [MLDeviceInfo applicationLaunchedCurrentTimestamp];
        _timestampString = [MLDeviceInfo applicationTimestampString];
        _appDisplayName = [MLDeviceInfo applicationDisplayName];
        _appVersion = [MLDeviceInfo applicationVersion];
        _systemVersion = [MLDeviceInfo phoneSystemVersion];
        _preferredLanguage = [MLDeviceInfo systemPreferredLanguage];
        _phoneModel = [MLDeviceInfo phoneModel];
        _deviceName = [MLDeviceInfo deviceName];
        _batteryLevel = [MLDeviceInfo batteryLevel];
        _totalMemorySize = [MLDeviceInfo totalMemorySize];
        _availableMemorySize = [MLDeviceInfo availableMemorySize];
        _totalDiskSize = [MLDeviceInfo totalDiskSize];
        _availableDiskSize = [MLDeviceInfo availableDiskSize];
        _idfa = [MLDeviceInfo advertisingIdentifier];
        _countryCode = [MLDeviceInfo localCountryCode];
        _telephonyCarrier = [MLDeviceInfo telephonyCarrier];
        _mobileCountryCode = [MLDeviceInfo mobileCountryCode];
        _mobileNetworkCode = [MLDeviceInfo mobileNetworkCode];
        _ipAddress = [MLDeviceInfo deviceIpAddress];
        _wifiIpAddress = [MLDeviceInfo localWifiIpAddress];
        _wifiName = [MLDeviceInfo wifiName];
        _jailbroken = [MLDeviceInfo jailbrokenDevice];
        _brightness = [MLDeviceInfo brightness];
        _dns = [MLDeviceInfo domainNameSystemIp];
        _networkType = [MLDeviceInfo networkType];
        _idfv = [MLDeviceInfo identifierForVendor];
        
        _cpuFrequeny = [MLDeviceInfo cpuFrequency];
        _cpuCount = [MLDeviceInfo cpuCount];
        _busFrequency = [MLDeviceInfo busFrequency];
        _macaddress = [MLDeviceInfo macaddress];
        _hwmodel = [MLDeviceInfo hwmodel];
        
        _currentDeviceName = [MLDeviceInfo currentDeviceName];
        
        _kernelVersion = [MLDeviceInfo kernelVersion];
        _darwinBuildDescription = [MLDeviceInfo darwinBuildDescription];
    }

    return self;
}

-(NSString *)description{

    return [NSString stringWithFormat:@"当前手机名字--%@,时间戳--%f,\n系统时间--%@,\n应用名称--%@,\n应用版本--%@,\n系统版本--%@,\n当前语言--%@,\n设备名称--%@,\n剩余电量--%f,\n总内存容量--%lld,\n可用内存--%lld,\n总存储空间--%lld,\n可用存储空间--%lld,\nIDFA--%@,\nIDFV--%@,\n国家代码--%@,\n运营商--%@,\nMCC--%@,\nMNC--%@,\nIP--%@,\nWifiIP--%@,\nWifiName--%@,\n是否越狱--%d,\n屏幕亮度--%f,\nDNS--%@,\n网络接入类型--%@,\nCPU频率--%zd,\nCPU数量--%zd,\n总线--%zd,\n mac地址--%@,\n硬件模型--%@,\n内核版本号==%@,\n内核描述--%@",_currentDeviceName,_currentTimestamp,_timestampString,_appDisplayName,_appVersion,_systemVersion,_preferredLanguage,_deviceName,_batteryLevel,_totalMemorySize,_availableMemorySize,_totalDiskSize,_availableDiskSize,_idfa,_idfv,_countryCode,_telephonyCarrier,_mobileCountryCode,_mobileNetworkCode,_ipAddress,_wifiIpAddress,_wifiName,_jailbroken,_brightness,_dns,_networkType,_cpuFrequeny,_cpuCount,_busFrequency,_macaddress,_hwmodel,_kernelVersion,_darwinBuildDescription];

}

@end
