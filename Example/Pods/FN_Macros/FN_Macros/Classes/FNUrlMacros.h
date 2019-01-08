//
//  FNUrlMacros.h
//  FNYunWei
//
//  Created by qunye zhu on 2018/3/30.
//  Copyright © 2018年 qunye zhu. All rights reserved.
//

#ifndef FNUrlMacros_h
#define FNUrlMacros_h

#define kRequestHomeUrl(url)                [NSString stringWithFormat:@"%@%@",kFanNengApiBase,url]

// **************************登录****************************

// POST 用户绑定
#define kBindUrl        kRequestHomeUrl(@"/hps/index/bind")
// POST 用户解绑
#define kUnbindUrl        kRequestHomeUrl(@"/hps/index/unbind")
// POST 用户登录
#define kLoginUrl        kRequestHomeUrl(@"/hps/index/login")
// POST 用户登录退出
#define kLogoutUrl        kRequestHomeUrl(@"/hps/index/logout")

// **************************首页****************************

// POST 获取锅炉设备详情[曲线图]
#define kBoilerDetailUrl        kRequestHomeUrl(@"/hps/device/boiler/detail")
// POST 获取锅炉状态
#define kBoilerStatusUrl        kRequestHomeUrl(@"/hps/device/boiler/getStatus")
// POST 启动锅炉
#define kBoilerStartUrl        kRequestHomeUrl(@"/hps/device/boiler/start")
// POST 停止锅炉
#define kBoilerStopUrl        kRequestHomeUrl(@"/hps/device/boiler/stop")
// POST 阀门详情
#define kvalveDetailUrl        kRequestHomeUrl(@"/hps/device/valve/detail")
// POST 获取关联综合能源用户
#define kValveRelationUrl      kRequestHomeUrl(@"/hps/device/getValveRelation")
// POST 阀门定时器信息展示
#define kValveDelaySelectUrl   kRequestHomeUrl(@"/hps/device/valve/valveDelay/select")
// POST 编辑阀门定时器
#define kValveDelayUpdateUrl   kRequestHomeUrl(@"/hps/device/valve/valveDelay/update")
// POST 开启、关闭阀门
#define kValveStartOrStop      kRequestHomeUrl(@"/hps/overview/regulatingValve/startOrStop")
// POST 阀门流量设置
#define kValveConfigUrl        kRequestHomeUrl(@"/hps/overview/regulatingValve/config")
// POST 阀门模式切换 3：手动；4：自动
#define kValveModeControlUrl        kRequestHomeUrl(@"/hps/overview/regulatingValve/control")

// GET 获取全部站点及设备
#define kDeviceInfoByStationIdUrl        kRequestHomeUrl(@"/hps/overview/getDeviceInfoByStationId")
// POST 获取全部站点及设备
#define kHomeInfoUrl        kRequestHomeUrl(@"/hps/overview/index")
// POST 压力设置
#define kPressureConfigUrl        kRequestHomeUrl(@"/hps/overview/pressure/config")
// POST 从Cim获取压力值
#define kPressureFromCimUrl        kRequestHomeUrl(@"/hps/overview/pressure/getFromCim")
// POST 水检周期设置
#define kWaterInspectionUrl        kRequestHomeUrl(@"/hps/overview/waterInspection/config")
// POST 从Cim获取水检周期
#define kWaterInspectionFromCimUrl        kRequestHomeUrl(@"/hps/overview/waterInspection/getFromCim")


// **************************工具****************************
// POST 数据采集文件上传
#define kAcquisitionUploadUrl        kRequestHomeUrl(@"/hps/kit/acquisition/upload")
// GET 焓熵值计算
#define kEnergyCalculateUrl        kRequestHomeUrl(@"/hps/kit/queryEEValue")
// GET 湿球温度计算
#define kTempCalculateUrl        kRequestHomeUrl(@"/hps/kit/queryWebBulbValue")
// GET 获取摄像头列表
#define kCameraListUrl        kRequestHomeUrl(@"/hps/device/camera/list")

// *************************消息*******************************

//维护消息-某个站点下所有设备的最新消息
#define kMessage_Maintain_Equipment_Select       kRequestHomeUrl(@"/hps/message/maintainMessage/equipment/select")
//批量维护消息设置为完成或忽略
#define kMessage_Maintain_Operation_Batch        kRequestHomeUrl(@"/hps/message/maintainMessage/operation/batch")
//维护消息提醒
#define kMessage_Maintain_Remind                  kRequestHomeUrl(@"/hps/message/maintainMessage/remind")
//某设备维护消息分页展示
#define kMessage_Maintain_SelectPage        kRequestHomeUrl(@"/hps/message/maintainMessage/selectPage")
//报警、操作消息分页展示
#define kMessage_SelectPage        kRequestHomeUrl(@"/hps/message/messageInfo/selectPage")
//消息总览
#define kMessage_Overview        kRequestHomeUrl(@"/hps/message/overview")
//站点下拉
#define kMessage_Station_Selector        kRequestHomeUrl(@"/hps/message/station/selector")

// GET /hps/message/getFilterList
#define kMessage_FilterList    kRequestHomeUrl(@"/hps/message/getFilterList")
// POST /hps/message/maintainMessage/paginateForAlarm
#define kMessage_Alarm    kRequestHomeUrl(@"/hps/message/maintainMessage/paginateForAlarm")
// POST /hps/message/maintainMessage/updateAlarmStatus
#define kMessage_UpdateAlarmStatus    kRequestHomeUrl(@"/hps/message/maintainMessage/updateAlarmStatus")
// POST /hps/message/maintainMessage/getAlarmDetail
#define kMessage_AlarmDetail    kRequestHomeUrl(@"/hps/message/maintainMessage/getAlarmDetail")


// **************************我的****************************

// POST 获取我的公司
#define kCompanyUrl        kRequestHomeUrl(@"/hps/mine/company/select")
// POST 编辑我的公司和站点的别名
#define kCompanyUpdateUrl      kRequestHomeUrl(@"/hps/mine/hpsAlias/alias/update")
// POST 我的公司和站点列表
#define kStationSelectUrl      kRequestHomeUrl(@"/hps/mine/hpsAlias/station/select")
// POST 获取站点的下拉列表
#define kStationsByOpenIdUrl      kRequestHomeUrl(@"/hps/mine/station/getStationByOpenId")
// POST 设备设置
#define kDeviceUpdateUrl      kRequestHomeUrl(@"/hps/mine/config/equipmentConfig/insertAndUpdate")
// GET 查询设备设置
#define kDeviceQueryUrl      kRequestHomeUrl(@"/hps/mine/config/config/equipmentConfig/query")
// POST 根据站点ID和设备ID查询站点设置信息
#define kDeviceSelectByDeviceUrl      kRequestHomeUrl(@"/hps/mine/config/equipmentConfig/selectByDevice")
// POST 价格设置+编辑
#define kPriceUpdateUrl      kRequestHomeUrl(@"/hps/mine/config/priceConfig/insertOrUpdate")
// POST 价格查询
#define kPriceQueryUrl      kRequestHomeUrl(@"/hps/mine/config/price/getPriceInfoOfStation")

#define kAboutUsUrl      kRequestHomeUrl(@"/hps/mine/config/aboutUs")

// **************************设备详情****************************

// GET 获取指标下拉
#define kGetIndicatorList        kRequestHomeUrl(@"/hps/device/getIndicatorList")

// POST 获取更多指标/指标数据曲线图
#define kGetIndicator       kRequestHomeUrl(@"/hps/device/getIndicator")

// POST 获取经济数据
#define kGetEconomicData       kRequestHomeUrl(@"/hps/device/getEconomicData")

#endif /* FNUrlMacros_h */

