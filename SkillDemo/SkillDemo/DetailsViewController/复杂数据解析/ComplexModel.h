//
//  ComplexModel.h
//  Mode
//
//  Created by pjw on 2020/12/10.
//

#import <Foundation/Foundation.h>
//#import <YYModel.h>
NS_ASSUME_NONNULL_BEGIN


@interface Gcxjgdzyb :NSObject <YYModel>
@property (nonatomic , copy) NSString              * F_WG_NAME;
@property (nonatomic , copy) NSString              * F_PG_ID;
@property (nonatomic , copy) NSString              * F_SP_TYPE;
@property (nonatomic , copy) NSString              * F_RES_TYPE;
@property (nonatomic , copy) NSString              * PROC_INST_ID_;
@property (nonatomic , copy) NSString              * row_version;
@property (nonatomic , copy) NSString              * row_time;
@property (nonatomic , copy) NSString              * F_RES_COUNT;
@property (nonatomic , copy) NSString              * F_RES_NAME;
@property (nonatomic , copy) NSString              * F_PARENT_RES_CODE;
@property (nonatomic , copy) NSString              * F_RES_LOCATION;
@property (nonatomic , copy) NSString              * F_REMARK;
@property (nonatomic , copy) NSString              * F_RES_CODE;
@property (nonatomic , copy) NSString              * F_PARENT_RES_NAME;

@end

@interface Gcxjgdgzjdb :NSObject <YYModel>
@property (nonatomic , copy) NSString              * F_WK_RESULT;
@property (nonatomic , copy) NSString              * row_version;
@property (nonatomic , copy) NSString              * F_WK_CONTENT;
@property (nonatomic , copy) NSString              * row_time;
@property (nonatomic , copy) NSString              * F_WK_NODE;
@property (nonatomic , copy) NSString              * PROC_INST_ID_;
@property (nonatomic , copy) NSString              * F_WK_ID;

@end

@interface SMInitDataModel :NSObject <YYModel>
@property (nonatomic , strong) Gcxjgdzyb              * gcxjgdzyb;
@property (nonatomic , strong) Gcxjgdgzjdb              * gcxjgdgzjdb;

@end

@interface Sub_gcxjgdgzjdb :NSObject <YYModel>
@property (nonatomic , copy) NSString              * row_version;
@property (nonatomic , copy) NSString              * proc_inst_id_;
@property (nonatomic , copy) NSString              * id_;
@property (nonatomic , copy) NSString              * F_WK_CONTENT;
@property (nonatomic , copy) NSString              * row_time;
@property (nonatomic , copy) NSString              * F_WK_NODE;
@property (nonatomic , copy) NSString              * F_WK_ID;
@property (nonatomic , copy) NSString              * ref_id_;

@end

@interface InstructionList :NSObject <YYModel>
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * instructionId;
@property (nonatomic , copy) NSString              * instructionContent;

@end

@interface DeviceList :NSObject <YYModel>
@property (nonatomic , copy) NSString              * result;
@property (nonatomic , copy) NSString              * picUrl;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * idString;
@property (nonatomic , copy) NSString              * resourceClassification;
@property (nonatomic , strong) NSArray<InstructionList *>              * instructionList;
@property (nonatomic , copy) NSString              * resId;
@property (nonatomic , copy) NSString              * name;

@end


@interface InstructionDto :NSObject <YYModel>
@property (nonatomic , copy) NSString              * result;
@property (nonatomic , copy) NSString              * picUrl;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * idString;
@property (nonatomic , copy) NSString              * resourceClassification;
@property (nonatomic , strong) NSArray<DeviceList *>              * deviceList;
@property (nonatomic , copy) NSString              * resId;
@property (nonatomic , strong) NSArray<InstructionList *>              * instructionList;
@property (nonatomic , copy) NSString              * bluetooth;
@property (nonatomic , copy) NSString              * name;

@end

@interface Sub_gcxjgdzyb :NSObject <YYModel>
@property (nonatomic , strong) InstructionDto              * instructionDto;
@property (nonatomic , copy) NSString              * proc_inst_id_;
@property (nonatomic , copy) NSString              * F_WG_NAME;
@property (nonatomic , copy) NSString              * id_;
@property (nonatomic , copy) NSString              * F_SP_TYPE;
@property (nonatomic , copy) NSString              * ref_id_;
@property (nonatomic , copy) NSString              * F_PG_ID;
@property (nonatomic , copy) NSString              * F_RES_TYPE;
@property (nonatomic , copy) NSString              * F_RES_LOCATION;
@property (nonatomic , copy) NSString              * row_time;
@property (nonatomic , copy) NSString              * F_RES_NAME;
@property (nonatomic , copy) NSString              * F_RES_COUNT;
@property (nonatomic , copy) NSString              * row_version;
@property (nonatomic , copy) NSString              * F_REMARK;
@property (nonatomic , copy) NSString              * F_RES_CODE;

@end

@interface ComplexModel :NSObject <YYModel>
@property (nonatomic , copy) NSString              * F_HANG_STATUS;
@property (nonatomic , assign) NSInteger              F_OT_HOURS;
@property (nonatomic , copy) NSString              * F_RES_ID;
@property (nonatomic , copy) NSString              * F_DIVIDE_ID;
@property (nonatomic , copy) NSString              * F_TIT_ID;
@property (nonatomic , copy) NSString              * F_PROCESS_NAME;
@property (nonatomic , copy) NSString              * F_CONTENT;
@property (nonatomic , copy) NSString              * row_time;
@property (nonatomic , copy) NSString              * row_version;
@property (nonatomic , copy) NSString              * F_RES_NAME;
@property (nonatomic , copy) NSString              * F_ORDER_NO;
@property (nonatomic , strong) SMInitDataModel       * dataModel;
@property (nonatomic , copy) NSString              * F_PROJECT_ID;
@property (nonatomic , copy) NSString              * F_OWNER_NAME;
@property (nonatomic , copy) NSString              * F_TX_NAME;
@property (nonatomic , copy) NSString              * F_WG_NAME;
@property (nonatomic , copy) NSString              * F_LOCATION;
@property (nonatomic , copy) NSString              * id_;
@property (nonatomic , copy) NSString              * F_WG_ID;
@property (nonatomic , copy) NSString              * F_OWNER_ID;
@property (nonatomic , copy) NSString              * F_DIVIDE_NAME;
@property (nonatomic , copy) NSString              * F_TX_CODE;
@property (nonatomic , copy) NSString              * F_TX_ID;
@property (nonatomic , copy) NSString              * F_FILES;
@property (nonatomic , copy) NSString              * F_OPER_CONTENT;
@property (nonatomic , copy) NSString              * F_WP_NAME;
@property (nonatomic , copy) NSString              * F_PROCESS_ID;
@property (nonatomic , copy) NSString              * REF_ID_;
@property (nonatomic , copy) NSString              * F_DEADLINE_TIME;
@property (nonatomic , assign) NSInteger           F_OT_STATUS;
@property (nonatomic , copy) NSString              * F_CREATE_TIME;
@property (nonatomic , copy) NSString              * F_PROJECT_NAME;
@property (nonatomic , assign) NSInteger              F_EXT_STATUS;
@property (nonatomic , strong) NSArray<Sub_gcxjgdgzjdb *>              * sub_gcxjgdgzjdb;
@property (nonatomic , copy) NSString              * F_TIT_NAME;
@property (nonatomic , copy) NSString              * F_STATUS;
@property (nonatomic , copy) NSString              * proc_inst_id_;
@property (nonatomic , strong) NSArray<Sub_gcxjgdzyb *>              * sub_gcxjgdzyb;
@property (nonatomic , copy) NSString              * F_WP_ID;
@property (nonatomic , copy) NSString              * F_ACT_FINISH_TIME;//实际完成时间



@end

@interface Data :NSObject <YYModel>
@property (nonatomic , strong) ComplexModel * engineering_inspection_model;

@end

@interface Value :NSObject <YYModel>
@property (nonatomic , strong) Data              * data;

@end

@interface WHC :NSObject <YYModel>
@property (nonatomic , assign) BOOL              state;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) Value              * value;

@end

NS_ASSUME_NONNULL_END
