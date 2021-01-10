//
//  ComplexModelVC.m
//  SkillDemo
//
//  Created by pjw on 2020/12/10.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ComplexModelVC.h"
#import "ComplexModel.h"
#import <NSObject+YYModel.h>

@interface ComplexModelVC ()
@property(nonatomic,strong)ComplexModel * model;
@end

@implementation ComplexModelVC

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self setModel];
}


-(void)setModel{
    NSDictionary * dict = @{
        @"state" : @true,
        @"message" : @"获取成功",
        @"value" : @{
                @"data" : @{
                        @"engineering_inspection_model" : @{
                            @"clock_sequence" : @"2",
                            @"F_HANG_STATUS" : @"0",
                            @"F_OT_HOURS" : @24,
                            @"F_RES_ID" : @"482998",
                            @"F_DIVIDE_ID" : @"45abdf914cda4132bd0b342cd04f3667",
                            @"F_TIT_ID" : @"00feb77d540649aabe0f857b289464f4",
                            @"F_PROCESS_NAME" : @"kf_renyuan",
                            @"F_CONTENT" : @"",
                            @"row_time" : @"2020-12-09",
                            @"row_version" : @"2020-12-09",
                            @"F_RES_NAME" : @"躺椅",
                            @"F_ORDER_NO" : @"SMFW-02-01-201302-01-01-00-GC-GD-20201209100000",
                            @"initData" : @{
                                    @"gcxjgdzyb" : @{
                                            @"F_WG_NAME" : @"",
                                            @"F_PG_ID" : @"",
                                            @"F_SP_TYPE" : @"",
                                            @"F_RES_TYPE" : @"",
                                            @"PROC_INST_ID_" : @"",
                                            @"row_version" :@"",
                                            @"row_time" : @"",
                                            @"F_RES_COUNT" : @"",
                                            @"F_RES_NAME" : @"",
                                            @"F_PARENT_RES_CODE" : @"",
                                            @"F_RES_LOCATION" : @"",
                                            @"F_REMARK" : @"",
                                            @"F_RES_CODE" : @"",
                                            @"F_PARENT_RES_NAME" : @""
                },
                                    @"gcxjgdgzjdb" : @{
                                            @"F_WK_RESULT" : @"",
                                            @"row_version" : @"",
                                            @"F_WK_CONTENT" : @"",
                                            @"row_time" : @"",
                                            @"F_WK_NODE" : @"",
                                            @"PROC_INST_ID_" : @"",
                                            @"F_WK_ID" : @""
                }
              },
                            @"F_PROJECT_ID" : @"c8c3ffada2d2468bb5f43769ceb8c117",
                            @"F_OWNER_NAME" : @"kf_renyuan",
                            @"F_TX_NAME" : @"工程",
                            @"F_WG_NAME" : @"123",
                            @"F_LOCATION" : @"西区中轴线28幢旁北侧",
                            @"id_" : @"5708109dc7754019aca0d8e59cd7e606",
                            @"F_WG_ID" : @"eca951bd-18fb-4492-97c9-34f035842a22",
                            @"F_OWNER_ID" : @"5c590b04aeef4418b13f070b67bc8563",
                            @"F_DIVIDE_NAME" : @"上海天马假日城地块",
                            @"F_TX_CODE" : @"engineering_classification",
                            @"F_TX_ID" : @"482907",
                            @"F_FILES" : @"",
                            @"F_OPER_CONTENT" : @"12",
                            @"F_WP_NAME" : @"213123123123123",
                            @"F_PROCESS_ID" : @"5c590b04aeef4418b13f070b67bc8563",
                            @"REF_ID_" : @"",
                            @"F_DEADLINE_TIME" : @"2020-12-10 10:48:09",
                            @"F_OT_STATUS" : @0,
                            @"F_CREATE_TIME" : @"2020-12-09 08:48:09",
                            @"F_PROJECT_NAME" : @"上海天马假日城",
                            @"F_EXT_STATUS" : @0,
                            @"sub_gcxjgdgzjdb" : @[
                                                  @{
                                                      @"row_version" : @"2020-12-09",
                                                      @"proc_inst_id_" : @"53f1c2e8b8ab492abaaf86550ccfc29d",
                                                      @"id_" : @"e3f1cab6da4b4c0395d3df3a026e8ed8",
                                                      @"F_WK_CONTENT" : @"1",
                                                      @"row_time" : @"2020-12-09",
                                                      @"F_WK_NODE" : @"2",
                                                      @"F_WK_ID" : @"1",
                                                      @"ref_id_" : @"5708109dc7754019aca0d8e59cd7e606"
                }
              ],
                            @"F_TIT_NAME" : @"网格管家",
                            @"F_STATUS" : @"2",
                            @"proc_inst_id_" : @"53f1c2e8b8ab492abaaf86550ccfc29d",
                            @"sub_gcxjgdzyb" : @[
                                    @{
                                        @"instructionDto" : @{
                                                @"result" : @"[{\"instructionId:\"1001\",\"status\":\"1\"\"}]",
                                                @"picUrl" : @"baidu.com",
                                                @"content" : @"设施的",
                                                @"id" : @"1",
                                                @"resourceClassification" : @"482998",
                                                @"deviceList" : @[
                                                        @{
                                                            @"result" : @"[{\"instructionId:\"1001\",\"status\":\"1\"\"}]",
                                                            @"picUrl" : @"baidu.com",
                                                            @"content" : @"设备的",
                                                            @"id" : @"2",
                                                            @"resourceClassification" : @"484403",
                                                            @"instructionList" : @[
                                                                    @{
                                                                        @"name" : @"园区照明",
                                                                        @"instructionId" : @"f6fdd3e9-a7b1-43af-92a3-c88dbc474d6d",
                                                                        @"instructionContent" : @"2"
                          }
                        ],
                                                            @"resId" : @"00041ddf9fc64ae984d981a151fa637b",
                                                            @"name" : @"园区3幢345号门口右侧门柱灯"
                      },
                                                        @{
                                                            @"instructionList" : @[
                                                                    @{
                                                                        @"name" : @"弱点",
                                                                        @"instructionId" : @"146b0c7f-5509-4251-9dc7-2e2594fb0bf6",
                                                                        @"instructionContent" : @"1"
                          }
                        ],
                                                            @"name" : @"地库18幢517号门禁通道2#弱电间",
                                                            @"resId" : @"0011cd3b2a3e459a94bacf9bd7b18d6d",
                                                            @"resourceClassification" : @"489533"
                      }
                    ],
                                                @"resId" : @"d27c913ef97649a0bf9d618ccb37cad5",
                                                @"instructionList" : @[
                                                        @{
                                                            @"name" : @"测试指导120902",
                                                            @"instructionId" : @"9e4b2dd4-1223-47cd-9106-60393fe64936"
                      },
                                                        @{
                                                            @"name" : @"工作指导",
                                                            @"instructionId" : @"eca951bd-18fb-4492-97c9-34f035842a22",
                                                            @"instructionContent" : @"1、穿戴绝缘鞋\n2、停电保养，无法停电的设备操作人员必须带绝缘手套、脚底垫垫绝缘胶垫，并有经验的人进行监护\n3、操作工具需有良好绝缘\n4、验电器使用前需对带电物验证确认后，才能使用\n"
                      }
                    ],
                                                @"bluetooth" : @"0",
                                                @"name" : @"西区中轴线28幢旁北侧公园椅"
                  },
                                        @"proc_inst_id_" : @"53f1c2e8b8ab492abaaf86550ccfc29d",
                                        @"F_WG_NAME" : @"123",
                                        @"id_" : @"f14f2e42fa4d48c88d45eb5c5399b643",
                                        @"F_SP_TYPE" : @"swgq",
                                        @"ref_id_" : @"5708109dc7754019aca0d8e59cd7e606",
                                        @"F_PG_ID" : @"eca951bd-18fb-4492-97c9-34f035842a22",
                                        @"F_RES_TYPE" : @"SLYZ",
                                        @"F_RES_LOCATION" : @"西区中轴线28幢旁北侧",
                                        @"row_time" : @"2020-12-09",
                                        @"F_RES_NAME" : @"西区中轴线28幢旁北侧公园椅",
                                        @"F_RES_COUNT" : @"1",
                                        @"row_version" : @"2020-12-09",
                                        @"F_REMARK" : @"",
                                        @"F_RES_CODE" : @"SH-TMJR-GC-GCGL-4790"
                }
              ],
                            @"F_WP_ID" : @"d0cf7a09a5cc40518dddbb9623c024c0"
            }
          }
        }
    };
    
    NSDictionary * para = dict[@"value"][@"data"][@"engineering_inspection_model"];
    
    
    self.model = [ComplexModel modelWithDictionary:para];
    Sub_gcxjgdzyb * model1 = self.model.sub_gcxjgdzyb.firstObject;
    InstructionDto * model2 = model1.instructionDto;
    NSLog(@" pjw       %@",model2.content);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.model = [ComplexModel new];
    
    
}


@end
