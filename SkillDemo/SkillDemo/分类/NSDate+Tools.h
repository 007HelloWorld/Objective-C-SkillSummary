//
//  NSDate+Tools.h
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef CGFloat TimeZoneEquation;

#define TimeZone_UTC_Less_12        -12.0f          //只有当船在经度180°以东7.5°内使用
#define TimeZone_UTC_Less_11        -11.0f          //中途岛,纽埃岛,萨摩亚群岛,美属萨摩亚
#define TimeZone_UTC_Less_10        -10.0f          //HST-美国夏威夷标准时间）,法属玻里尼西亚(社会群岛),夏威夷群岛,约翰斯顿环礁（约翰斯顿岛）
#define TimeZone_UTC_Less_9_30      -9.5f           //法属玻里尼西亚(马克萨斯群岛)
#define TimeZone_UTC_Less_9         -9.0f           //(AKST-美国阿拉斯加州标准时间(,法属玻里尼西亚(甘比尔群岛),美国(阿拉斯加州*)
#define TimeZone_UTC_Less_8         -8.0f           //(PST-加拿大及美国太平洋标准时间(,加拿大(卑诗省*,育空地区*),墨西哥(下加利福尼亚州*),美国(加利福尼亚州*,爱达荷州*,内华达州*,俄勒冈州*,华盛顿州*)
#define TimeZone_UTC_Less_7         -7.0f           //(MST-美国山区标准时间),加拿大(亚省*、西北地方、努纳瓦特山区*),墨西哥(南下加利福尼亚州*、奇瓦瓦州*、纳亚里特州*、锡那罗亚州*、索诺拉州),美国(亚利桑那州、*科罗拉多州*、*爱达荷州(南方)*、*蒙大拿州*,*内布拉斯加州(西部)*、*新墨西哥州*、北达科他州(西部)*、南达科他州*、犹他州*、怀俄明州*)
#define TimeZone_UTC_Less_6         -6.0f           //(CST-美国中部标准时间),伯利兹,加拿大(马尼托巴省*,努纳瓦特地区(南汉姆顿岛),努纳瓦特地区中部*,安大略省西部*,萨斯喀彻温省)。,智利(复活节岛),哥斯达黎加,厄瓜多尔(科隆群岛),萨尔瓦多,危地马拉,洪都拉斯,尼加拉瓜,美国(亚拉巴马州*,阿肯色州*,伊利诺州*,艾奥瓦州*,堪萨斯州*,肯塔基州(西部)*,路易斯安那州*,明尼苏达州*,密西西比州*,密苏里州*,内布拉斯加州(东部)*,北达科他州*,俄克拉何马州*,南达科他州(东部)*,田纳西州(中西部)*,得克萨斯州*,威斯康星州*)
#define TimeZone_UTC_Less_5         -5.0f           //(EST-美国东部标准时间),巴西(Acre),加拿大(努纳瓦特地区东部*、安大略省*、魁北克省*),开曼群岛,哥伦比亚,古巴*,厄瓜多尔,海地,牙买加,巴拿马,秘鲁,特克斯和凯科斯群岛*,美国(康涅狄格州*,特拉华州*,华盛顿特区*,佛罗里达州*,佐治亚州*,印第安纳州*,肯塔基州(东部)*,缅因州*,马里兰州*,马萨诸塞州*,密西根州*,新罕布什尔州*,新泽西州*,纽约州*,北卡罗来纳州*,俄亥俄州*,宾夕法尼亚州*,罗德艾兰州*,南卡罗来纳州*,田纳西州(东部)*,佛蒙特州*,弗吉尼亚州*,西弗吉尼亚州*)
#define TimeZone_UTC_Less_4_30      -4.5f           //委内瑞拉
#define TimeZone_UTC_Less_4         -4.0f           //(AST-美国大西洋标准时间),安圭拉,安提瓜和巴布达,阿鲁巴,巴巴多斯,玻利维亚,巴西(阿拉戈阿斯,马托格罗索*,南马托格罗索*,帕拉(西部),朗多尼亚,罗赖马),加拿大(纽芬兰与拉布拉多省*,新不伦瑞克省*,诺华斯高沙省*,爱德华王子岛省*),智利*,多米尼加共和国,福克兰群岛(英称)*马尔维纳斯群岛(阿根廷称)*,格林纳达,瓜德罗普岛,圭亚那,马提尼克岛,蒙特塞拉特,荷属安地列斯,巴拉圭*,百慕大群岛*,波多黎各,圣基茨和尼维斯,圣卢西亚,圣文森特和格林纳丁斯,特立尼达和多巴哥,维尔京群岛
#define TimeZone_UTC_Less_3_30      -3.5f           //(NST-加拿大纽芬兰标准时间)加拿大(纽芬兰*)
#define TimeZone_UTC_Less_3         -3.0f           //阿根廷,巴哈马*,巴西(Alagoas,Amapa,Bahia*,Ceara,DistritoFederal*,EspirtoSanto*,Goias*,Maranhao,MinasGerais*,Para(eastern),Paraiba,Parana*,Pernambuco,Piaui,RiodeJaneiro*,RioGrandedoNorte,RioGrandedoSul*,SantaCatarina*,SaoPaulo*,Sergipe,Tocantins*),法属圭亚那*,格陵兰,圣皮埃尔和密克隆群岛*,苏里南,乌拉圭
#define TimeZone_UTC_Less_2         -2.0f           //巴西(费尔南多-迪诺罗尼亚群岛)
#define TimeZone_UTC_Less_1         -1.0f           //维德岛,葡萄牙(亚速尔群岛*)
#define TimeZone_UTC                .0f             //(WET-西部欧洲时间,GMT-格林尼治标准时间),布基纳法索,科特迪瓦,法罗群岛*,冈比亚,迦纳,几内亚,几内亚比绍,冰岛,爱尔兰*,利比里亚,马里,毛里塔尼亚,摩洛哥,葡萄牙*,圣赫勒拿,圣多美和普林西比,塞内加尔,塞拉利昂,西班牙(加那利群岛)*,多哥,英国*
#define TimeZone_UTC_Plus_1         1.0f            //(CET-中部欧洲时间),阿尔巴尼亚*,安道尔*,安哥拉,奥地利*,比利时*,贝宁,波士尼亚赫塞哥维纳*,喀麦隆,中非共和国,乍得,刚果共和国,刚果民主共和国(金沙萨,Bandungu,Bas-Zaire,Equateur),克罗埃西亚*,捷克*,丹麦*,赤道几内亚,法国*,加蓬,德国*,直布罗陀*,匈牙利*,意大利*,列支敦士登*,卢森堡*,马其顿*,摩纳哥*,黑山*,纳米比亚*,荷兰*,尼日尔,尼日利亚,挪威*,波兰*,圣马力诺*,塞尔维亚*,斯洛伐克*,斯洛文尼亚*,西班牙*,斯瓦尔巴群岛和扬马延岛*,瑞典*,瑞士*,梵蒂冈*
#define TimeZone_UTC_Plus_2         2.0f            //(EET-欧洲东部时间),白俄罗斯*,博茨瓦纳,保加利亚*,布隆迪,刚果民主共和国(KasaiOccidental,KasaiOriental,Haut-Zaire,Shaba),塞浦路斯*,埃及*,爱沙尼亚,芬兰*,希腊*,以色列*,约旦,拉脱维亚*,黎巴嫩*,莱索托,利比亚,立陶宛,马拉维,摩尔多瓦*,莫桑比克,巴勒斯坦*,罗马尼亚*,俄罗斯(Zone1*,包括加里宁格勒州),卢旺达,南非,斯威士兰,叙利亚*,土耳其*,乌克兰*,赞比亚（即赞比亚）,津巴布韦（即津巴布韦）
#define TimeZone_UTC_Plus_3         3.0f            //(莫斯科时间),巴林,科摩洛,吉布提,厄立特里亚,埃塞俄比亚,伊拉克*,肯尼亚,科威特,马达加斯加,马约特,卡达,俄罗斯(Zone2*,包括莫斯科和圣彼得堡),沙特阿拉伯（即沙特阿拉伯）,索马里,苏丹,坦桑尼亚,乌干达,也门（即也门）
#define TimeZone_UTC_Plus_3_30      3.5f            //伊朗*
#define TimeZone_UTC_Plus_4         4.0f            //格鲁吉亚*,哈萨克斯坦*(西部),毛里求斯,阿曼,俄罗斯(Zone3*),塞舌尔,阿拉伯联合酋长国
#define TimeZone_UTC_Plus_4_30      4.5f            //阿富汗
#define TimeZone_UTC_Plus_5         5.0f            //亚美尼亚,阿塞拜疆*,哈萨克斯坦*(中部),吉尔吉斯斯坦*,马尔代夫,巴基斯坦,俄罗斯(Zone4*,包括叶卡捷琳堡和皮尔姆),塔吉克斯坦,土库曼斯坦,乌兹别克斯坦
#define TimeZone_UTC_Plus_5_30      5.5f            //印度,斯里兰卡
#define TimeZone_UTC_Plus_5_45      5.75f           //尼泊尔
#define TimeZone_UTC_Plus_6         6.0f            //孟加拉,不丹,哈萨克斯坦*(东部),俄罗斯(Zone5*,包括新西伯利亚和鄂木斯克)
#define TimeZone_UTC_Plus_6_30      6.5f            //澳大利亚(科科斯(基林)群岛),缅甸
#define TimeZone_UTC_Plus_7         7.0f            //柬埔寨,澳大利亚(圣诞岛),印尼(西部),老挝,俄罗斯(Zone6*),泰国,越南
#define TimeZone_UTC_Plus_8         8.0f            //(北京标准时间)CST-北京标准时间,HKT-香港时间,TST-台湾标准时,文莱,中国：北京时间,香港特区：香港时间,澳门特区,俄罗斯(Zone7*),蒙古国,台湾：国家标准时间,新加坡,马来西亚,印尼(中部),菲律宾,澳大利亚-西澳：AWST-澳大利亚西部标准时间
#define TimeZone_UTC_Plus_9         9.0f            //(JST-日本标准时间),日本,印尼(东部),东帝汶,帕劳(即帕劳),俄罗斯(Zone*8,包括Yakutsk),朝鲜,韩国
#define TimeZone_UTC_Plus_9_30      9.5f            //(ACST-澳大利亚中部标准时间),澳大利亚(新南威尔士州的布罗肯希尔*,北领地,南澳大利亚*三地采用)
#define TimeZone_UTC_Plus_10        10.0f           //(AEST-澳大利亚东部标准时间),巴布亚新几内亚,北马里亚纳群岛,科克群岛*,俄罗斯(Zone9*,包括海参崴),密克罗尼西亚联邦(YapandChuuk),澳大利亚(昆士兰省；澳大利亚首都特区*,布罗肯希尔以外的新南威尔士州*,维多利亚省*,塔斯马尼亚*),关岛
#define TimeZone_UTC_Plus_10_30     10.5f           //澳大利亚(豪勋爵群岛*)
#define TimeZone_UTC_Plus_11        11.0f           //瓦努阿图,所罗门群岛,俄罗斯(Zone10*),密克罗尼西亚联邦(KosraeandPohnpei),新喀里多尼亚(NewCaledonia)
#define TimeZone_UTC_Plus_11_30     11.5f           //诺福克岛
#define TimeZone_UTC_Plus_12        12.0f           //斐济*,基里巴斯(吉柏特岛),马绍尔群岛,瑙鲁,新西兰*,俄罗斯(Zone11*),图瓦卢,威克岛,瓦利斯和富图纳群岛
#define TimeZone_UTC_Plus_12_45     12.75f          //新西兰(查塔姆群岛*)
#define TimeZone_UTC_Plus_13        13.0f           //基里巴斯(菲尼克斯岛),汤加
#define TimeZone_UTC_Plus_14        14.0f           //基里巴斯(线岛)


NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Tools)

- (void)formatDateToEquation:(TimeZoneEquation) equation Year:(NSString **)year Month:(NSString **) month Day:(NSString **)day WeekDay:(NSString **)weekDay Hour:(NSString **) hour Minutes:(NSString **) minutes Second:(NSString **)second maxDaysInMonth:(NSString **)maxDays;


- (NSString *)stringWithFormatter:(NSString *)formatter;


@end

NS_ASSUME_NONNULL_END
