//
//  CUCFQuickCacheMacrocDefine.h
//  CatPaw
//
//  Created by lk on 2017/6/19.
//  Copyright © 2017年 lk. All rights reserved.
//

/**
 *  文件描述
 *
 *  这个工具类宏定义封装了对
 *  NSUserDefault,NSCache,NSFileManager
 *  NSKeyedArchieve,NSDocumentDirectory,NSCacheDirectory的便捷操作
 */

#import "CUCFQuickCacheUitil.h"
#import "LKTool.h"

/* 写宏定义的时候，前面变量参数的名字，多参数的时候不能方法名和后面调用方法的参数名字一样 */

/**
 *  检查一个valueObj,keyObj对象是否有一个是空的
 */
#define CUCFCheckKeyValueHasNull(keyObj,valueObj) [CUCFQuickCacheUitil checkValue:valueObj key:keyObj]

/**
 *  检查一个对象是否为空
 */
#define CUCFCheckObjectNull(object) [CUCFQuickCacheUitil isNullObject:object]

/**
 *  NSUserDefault 保存键值对 keyObj,valueObj
 */
#define CUCFUDFCache(keyObj,valueObj) [CUCFQuickCacheUitil userDefaultCache:valueObj key:keyObj]

/**
 *  NSUserDefault 删除键keyObj对应的值
 */
#define CUCFUDFRemove(keyObj) [CUCFQuickCacheUitil userDefaultRemove:keyObj]

/**
 *  NSUserDefault 获取键keyObj对应的值
 */
#define CUCFUDFGetValue(keyObj) [CUCFQuickCacheUitil userDefaultGetValue:keyObj]

/**
 *  NSUserDefault 判断键keyObject对应的值是否为空
 */
#define CUCFUDFEmptyValue(keyObj) [CUCFQuickCacheUitil userDefaultEmptyValue:keyObj]

/**
 *  NSCache 存储键值对 keyObj,valueObj
 */
#define CUCFNSCacheSet(keyObj,valueObj) [CUCFQuickCacheUitil systemMemoryCacheSet:valueObj key:keyObj]

/**
 *  NSCache 删除键keyObj对应的值
 */
#define CUCFNSCacheRemove(keyObj) [CUCFQuickCacheUitil systemMemoryCacheRemove:keyObj]

/**
 *  NSCache 获取键keyObj对应的值
 */
#define CUCFNSCacheGetValue(keyObj) [CUCFQuickCacheUitil systemMemoryCacheGetValue:keyObj]

/**
 *  NSCache 判断键keyObject对应的值是否为空
 */
#define CUCFNSCacheEmptyValue(keyObj) [CUCFQuickCacheUitil systemMemoryCacheEmptyValue:keyObj]

/**
 *  获取系统默认文件管理
 */
#define CUCFFileManager [CUCFQuickCacheUitil fileManager]

/**
 *  指定路径pathObj是否存在文件
 */
#define CUCFFileIsExist(pathObj) [CUCFQuickCacheUitil fileExist:pathObj]

/**
 *  指定路径pathObj是否存在目录
 */
#define CUCFFileDirectoryIsExist(pathObj) [CUCFQuickCacheUitil directoryExist:pathObj]

/**
 *  读取某个路径的二进制数据，返回 NSData
 */
#define CUCFFileRead(pathObj) [CUCFQuickCacheUitil readFromFile:pathObj]

/**
 *  将二进制数据写入文件 dataObj:NSData pathObj:NSString
 */
#define CUCFFileWrite(dataObj,pathObj) [CUCFQuickCacheUitil writeFileData:dataObj toPath:pathObj]

/**
 *  在指定路径创建目录，返回BOOL结果
 */
#define CUCFFileDirectoryCreate(pathObj) [CUCFQuickCacheUitil createDirectory:pathObj]

/**
 *  删除指定路径文件
 */
#define CUCFFileDeleteFile(path) [CUCFQuickCacheUitil deleteFileAtPath:path]

/**
 *  删除指定目录
 */
#define CUCFFileDeleteDirectory(path) [CUCFQuickCacheUitil deleteDirectoryAtPath:path]

/**
 *  从fromFilePath复制文件到toFilePath,shouldRemove标示是否删除复制源文件
 */
#define CUCFFileCopyFileIsRemove(fromFilePath,toFilePath,shouldRemove) [CUCFQuickCacheUitil copyFileFromPath:fromFilePath toPath:toFilePath isRemoveOld:shouldRemove]

/**
 *  将某个对象归档到指定路径
 */
#define CUCFArchieveObject(object,filePath) [CUCFQuickCacheUitil archieveObject:object toFilePath:filePath]

/**
 *  从指定路径读取被归档过的对象
 */
#define CUCFUnArchieveObject(fromFilePath) [CUCFQuickCacheUitil unarchieveFromPath:fromFilePath]

/**
 *  获取NSDocumentDirectory目录
 */
#define CUCFAppDocumentDirectory [CUCFQuickCacheUitil documentDirectory]

/**
 *  获取NSCacheDirectory目录
 */
#define CUCFAppCacheDirectory [CUCFQuickCacheUitil cacheDirectory]

/**
 *  返回文件名为fileName在NSDocumentDirectory中的路径
 */
#define CUCFAppDoucmentPath(fileName) [CUCFQuickCacheUitil documentDirectoryPath:fileName]

/**
 *  返回文件名为fileName在NSCacheDirectory中的路径
 */
#define CUCFAppCachePath(fileName) [CUCFQuickCacheUitil cacheDirectoryPath:fileName]

/**
 *  将object对象用fileName名字保存到NSDocumentDirectory目录下
 */
#define CUCFAppDocumentSave(object,fileName) [CUCFQuickCacheUitil documentDirectorySave:object withFileName:fileName]

/**
 *  将object对象用fileName名字保存到NSCacheDirectory目录下
 */
#define CUCFAppCacheSave(object,fileName) [CUCFQuickCacheUitil cacheDirectorySave:object withFileName:fileName]

/**
 *  删除NSDocumentDirectory目录下名为fileName的文件
 */
#define CUCFAppDocumentDelete(fileName)  [CUCFQuickCacheUitil documentDirectoryDelete:fileName]

/**
 *  删除NSCacheDirectory目录下名为fileName的文件
 */
#define CUCFAppCacheDelete(fileName) [CUCFQuickCacheUitil cacheDirectoryDelete:fileName]
