//
//  FJRegion.m
//  FJTool
//
//  Created by Jeff on 2017/2/28.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJRegion.h"
#import "RegionModel.h"
#import "PodHelper.h"

@implementation FJRegion

// 是否是Chinese Locale
+ (BOOL)isChineseLanguage
{
    return [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] containsString:@"zh"];
}

// 所有国家索引
+(NSArray*)countrySections
{
    if ([self isChineseLanguage]) {
        return [NSArray arrayWithObjects:@"热", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"J", @"K", @"L", @"M", @"N", @"P", @"R", @"S", @"T", @"W", @"X", @"Y", @"Z", nil];
    }
    else {
        return [NSArray arrayWithObjects:@"热", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"Y", @"Z", nil];
    }
}

// 所有国家代码
+(NSArray*)allCountryCodes
{
    if ([self isChineseLanguage]) {
        return [NSArray arrayWithObjects: @"86", @"61", @"1",@"33", @"39", @"81", @"82", @"44", @"1", @"355",@"213",@"93",@"54",@"971",@"968",@"994",@"247",@"20",@"251",@"353",@"372",@"376",@"244",@"1264",@"1268",@"43",@"61",@"853",@"1246",@"675",@"1242",@"92",@"595",@"973",@"507",@"55",@"375",@"1441",@"359",@"229",@"32",@"354",@"591",@"1787",@"48",@"267",@"501",@"226",@"257",@"850",@"45",@"49",@"684",@"228",@"1890",@"7",@"593",@"33",@"689",@"594",@"679",@"63",@"358",@"220",@"242",@"57",@"506",@"1809",@"995",@"53",@"1671",@"592",@"327",@"509",@"82",@"31",@"599",@"504",@"253",@"331",@"224",@"233",@"241",@"855",@"420",@"263",@"237",@"974",@"1345",@"225",@"965",@"385",@"254",@"682",@"371",@"266",@"856",@"961",@"231",@"218",@"370",@"423",@"262",@"352",@"40",@"261",@"356",@"960",@"265",@"60",@"223",@"1670",@"596",@"230",@"1",@"976",@"1664",@"880",@"51",@"95",@"373",@"212",@"377",@"258",@"52",@"264",@"27",@"381",@"674",@"977",@"505",@"227",@"234",@"47",@"351",@"81",@"46",@"41",@"503",@"232",@"221",@"357",@"248",@"966",@"239",@"1758",@"378",@"1784",@"94",@"421",@"386",@"268",@"249",@"597",@"252",@"677",@"992",@"886",@"66",@"255",@"676",@"1809",@"216",@"90",@"993",@"502",@"58",@"673",@"256",@"380",@"598",@"998",@"34",@"685",@"30",@"852",@"65",@"64",@"36",@"963",@"1876",@"374",@"967",@"964",@"98",@"972",@"39",@"91",@"62",@"44",@"962",@"84",@"260",@"243",@"235",@"350",@"56",@"236",@"86", nil];
    }
    return [NSArray arrayWithObjects: @"86", @"61", @"1",@"33", @"39", @"81", @"82", @"44", @"1",
            @"93",@"355",@"213",@"376",@"244",@"1264",@"1268",@"54",@"374",@"247",@"61",@"43",@"994",@"1242",@"973",@"880",@"1246",@"375",@"32",@"501",@"229",@"1441",@"591",@"267",@"55",@"44",@"673",@"359",@"226",@"257",@"855",@"237",@"1345",@"236",@"235",@"56",@"86",@"57",@"242",@"682",@"506",@"225",@"385",@"53",@"357",@"420",@"45",@"253",@"1890",@"684",@"593",@"20",@"503",@"372",@"251",@"679",@"358",@"33",@"594",@"689",@"241",@"220",@"995",@"49",@"233",@"350",@"30",@"1809",@"1671",@"502",@"224",@"592",@"509",@"504",@"852",@"36",@"354",@"91",@"62",@"98",@"964",@"353",@"972",@"39",@"1876",@"81",@"962",@"327",@"254",@"850",@"82",@"965",@"331",@"856",@"371",@"961",@"266",@"231",@"218",@"423",@"370",@"352",@"853",@"261",@"265",@"60",@"960",@"223",@"356",@"1670",@"596",@"230",@"52",@"373",@"377",@"976",@"1664",@"212",@"258",@"95",@"264",@"674",@"977",@"31",@"599",@"64",@"505",@"227",@"234",@"47",@"968",@"92",@"507",@"675",@"595",@"51",@"63",@"48",@"351",@"1787",@"974",@"262",@"40",@"7",@"1758",@"378",@"239",@"966",@"221",@"248",@"232",@"65",@"421",@"386",@"677",@"252",@"27",@"34",@"94",@"1784",@"249",@"597",@"268",@"46",@"41",@"963",@"886",@"992",@"255",@"66",@"228",@"676",@"1809",@"216",@"90",@"993",@"256",@"380",@"971",@"1",@"598",@"998",@"58",@"84",@"685",@"967",@"381",@"243",@"260",@"263",nil];
}

// 所有国家
+(NSArray*)allCountries
{
    if ([self isChineseLanguage]) {
        return [NSMutableArray arrayWithObjects:
                [NSArray arrayWithObjects:@"中国",@"澳大利亚",@"加拿大",@"法国",@"意大利",@"日本",@"韩国",@"英国",@"美国", nil],
                [NSArray arrayWithObjects: @"阿尔巴尼亚",@"阿尔及利亚",@"阿富汗",@"阿根廷",@"阿拉伯联合酋长国",@"阿曼",@"阿塞拜疆",@"阿森松",@"埃及",@"埃塞俄比亚",@"爱尔兰",@"爱沙尼亚",@"安道尔共和国",@"安哥拉",@"安圭拉岛",@"安提瓜和巴布达",@"奥地利",@"澳大利亚",@"澳门",nil],
                [NSArray arrayWithObjects:@"巴巴多斯",@"巴布亚新几内亚",@"巴哈马",@"巴基斯坦",@"巴拉圭",@"巴林",@"巴拿马",@"巴西",@"白俄罗斯",@"百慕大群岛",@"保加利亚",@"贝宁",@"比利时",@"冰岛",@"玻利维亚",@"波多黎各",@"波兰",@"博茨瓦纳",@"伯利兹",@"布基纳法索",@"布隆迪",nil],
                [NSArray arrayWithObjects:@"朝鲜",nil],
                [NSArray arrayWithObjects:@"丹麦",@"德国",@"东萨摩亚(美)",@"多哥",@"多米尼加共和国", nil],
                [NSArray arrayWithObjects:@"俄罗斯",@"厄瓜多尔",nil],
                [NSArray arrayWithObjects:@"法国",@"法属玻利尼西亚",@"法属圭亚那",@"斐济",@"菲律宾",@"芬兰",nil],
                [NSArray arrayWithObjects: @"冈比亚",@"刚果",@"哥伦比亚",@"哥斯达黎加",@"格林纳达",@"格鲁吉亚",@"古巴",@"关岛",@"圭亚那",nil],
                [NSArray arrayWithObjects: @"哈萨克斯坦",@"海地",@"韩国",@"荷兰",@"荷属安的列斯",@"洪都拉斯",nil],
                [NSArray arrayWithObjects: @"吉布提",@"吉尔吉斯坦",@"几内亚",@"加纳",@"加蓬",@"柬埔寨",@"捷克",@"津巴布韦",nil],
                [NSArray arrayWithObjects:@"喀麦隆",@"卡塔尔",@"开曼群岛",@"科特迪瓦",@"科威特",@"克罗地亚",@"肯尼亚",@"库克群岛",nil],
                [NSArray arrayWithObjects:@"拉脱维亚",@"莱索托",@"老挝",@"黎巴嫩",@"利比里亚",@"利比亚",@"立陶宛",@"列支敦士登",@"留尼旺",@"卢森堡",@"罗马尼亚",nil],
                [NSArray arrayWithObjects:@"马达加斯加",@"马耳他",@"马尔代夫",@"马拉维",@"马来西亚",@"马里",@"马里亚那群岛",@"马提尼克",@"毛里求斯",@"美国",@"蒙古",@"蒙特塞拉特岛",@"孟加拉国",@"秘鲁",@"缅甸",@"摩尔多瓦",@"摩洛哥",@"摩纳哥",@"莫桑比克",@"墨西哥",nil],
                [NSArray arrayWithObjects:@"纳米比亚",@"南非",@"南斯拉夫",@"瑙鲁",@"尼泊尔",@"尼加拉瓜",@"尼日尔",@"尼日利亚",@"挪威",nil],
                [NSArray arrayWithObjects: @"葡萄牙",nil],
                [NSArray arrayWithObjects:@"日本",@"瑞典",@"瑞士",nil],
                [NSArray arrayWithObjects:@"萨尔瓦多",@"塞拉利昂",@"塞内加尔",@"塞浦路斯",@"塞舌尔",@"沙特阿拉伯",@"圣多美和普林西比",@"圣卢西亚",@"圣马力诺",@"圣文森特",@"斯里兰卡",@"斯洛伐克",@"斯洛文尼亚",@"斯威士兰",@"苏丹",@"苏里南",@"索马里",@"所罗门群岛",nil],
                [NSArray arrayWithObjects:@"塔吉克斯坦",@"中国台湾",@"泰国",@"坦桑尼亚",@"汤加",@"特立尼达和多巴哥",@"突尼斯",@"土耳其",@"土库曼斯坦",nil],
                [NSArray arrayWithObjects:@"危地马拉",@"委内瑞拉",@"文莱",@"乌干达",@"乌克兰",@"乌拉圭",@"乌兹别克斯坦",nil],
                [NSArray arrayWithObjects:@"西班牙",@"西萨摩亚",@"希腊",@"香港",@"新加坡",@"新西兰",@"匈牙利",@"叙利亚",nil],
                [NSArray arrayWithObjects:@"牙买加",@"亚美尼亚",@"也门",@"伊拉克",@"伊朗",@"以色列",@"意大利",@"印度",@"印度尼西亚",@"英国",@"约旦",@"越南",nil],
                [NSArray arrayWithObjects:@"赞比亚",@"扎伊尔",@"乍得",@"直布罗陀",@"智利",@"中非共和国",@"中国",nil],
                nil];
    }
    else {
        return [NSMutableArray arrayWithObjects:
                [NSArray arrayWithObjects:@"China",@"Australia",@"Canada",@"France",@"Italy",@"Japan",@"Korea",@"United Kingdom",@"America", nil],
                [NSArray arrayWithObjects: @"Afghanistan",@"Albania",@"Algeria",@"Andorra",@"Angola",@"Anguilla",@"AntiguaandBarbuda",@"Argentina",@"Armenia",@"Ascension",@"Australia",@"Austria",@"Azerbaijan",nil],
                [NSArray arrayWithObjects:@"Bahamas",@"Bahrain",@"Bangladesh",@"Barbados",@"Belarus",@"Belgium",@"Belize",@"Benin",@"Bermuda",@"Bolivia",@"Botswana",@"Brazil",@"Britain",@"Brunei",@"Bulgaria",@"BurkinaFaso",@"Burundi", nil],
                [NSArray arrayWithObjects:@"Cambodia",@"Cameroon",@"CaymanIslands",@"CentralAfricanRepublic",@"Chad",@"Chile",@"China",@"Columbia",@"Congo",@"CookIslands",@"CostaRica",@"Cted'Ivoire",@"Croatia",@"Cuba",@"Cyprus",@"CzechRepublic", nil],
                [NSArray arrayWithObjects:@"Denmark",@"Djibouti",@"DominicanRepublic", nil],
                [NSArray arrayWithObjects:  @"EastSamoa(U.S.)",@"Ecuador",@"Egypt",@"ElSalvador",@"Estonia",@"Ethiopia", nil],
                [NSArray arrayWithObjects: @"Fiji",@"Finland",@"France",@"FrenchGuiana",@"FrenchPolynesia", nil],
                [NSArray arrayWithObjects: @"Gabon",@"Gambia",@"Georgia",@"Germany",@"Ghana",@"Gibraltar",@"Greece",@"Grenada",@"Guam",@"Guatemala",@"Guinea",@"Guyana",nil],
                [NSArray arrayWithObjects: @"Haiti",@"Honduras",@"HongKong",@"Hungary",nil],
                [NSArray arrayWithObjects:  @"Iceland",@"India",@"Indonesia",@"Iran",@"Iraq",@"Ireland",@"Israel",@"Italy", nil],
                [NSArray arrayWithObjects: @"Jamaica",@"Japan",@"Jordan",nil],
                [NSArray arrayWithObjects:@"Kazakhstan",@"Kenya",@"Korea(North)",@"Korea",@"Kuwait",@"Kyrgyzstan",nil],
                [NSArray arrayWithObjects:@"Laos",@"Latvia",@"Lebanon",@"Lesotho",@"Liberia",@"Libya",@"Liechtenstein",@"Lithuania",@"Luxembourg",nil],
                [NSArray arrayWithObjects:@"Macao",@"Madagascar",@"Malawi",@"Malaysia",@"Maldives",@"Mali",@"Malta",@"MarianaIslands",@"Martinique",@"Mauritius",@"Mexico",@"Moldova",@"Monaco",@"Mongolia",@"Montserrat",@"Morocco",@"Mozambique",@"Myanmar",nil],
                [NSArray arrayWithObjects:@"Namibia",@"Nauru",@"Nepal",@"Netherlands",@"NetherlandsAntilles",@"New Zealand",@"Nicaragua",@"Niger",@"Nigeria",@"Norway",nil],
                [NSArray arrayWithObjects: @"Oman",nil],
                [NSArray arrayWithObjects: @"Pakistan",@"Panama",@"PapuaNewGuinea",@"Paraguay",@"Peru",@"Philippines",@"Poland",@"Portugal",@"PuertoRico",nil],
                [NSArray arrayWithObjects:@"Qatar",nil],
                [NSArray arrayWithObjects:@"Reunion",@"Romania",@"Russia",nil],
                [NSArray arrayWithObjects:@"SaintLucia",@"SanMarino",@"SaoTomeandPrincipe",@"SaudiArabia",@"Senegal",@"Seychelles",@"SierraLeone",@"Singapore",@"Slovakia",@"Slovenia",@"SolomonIslands",@"Somalia",@"SouthAfrica",@"Spain",@"SriLanka",@"St.Vincent",@"Sudan",@"Surinam",@"Swaziland",@"Sweden",@"Switzerland",@"Syria",nil],
                [NSArray arrayWithObjects:@"Taiwan",@"Tajikistan",@"Tanzania",@"Thailand",@"Togo",@"Tonga",@"TrinidadandTobago",@"Tunisia",@"Turkey",@"Turkmenistan",nil],
                [NSArray arrayWithObjects:@"Uganda",@"Ukraine",@"UnitedArabEmirates",@"UnitedStates",@"Uruguay",@"Uzbekistan",nil],
                [NSArray arrayWithObjects:@"Venezuela",@"Vietnam",nil],
                [NSArray arrayWithObjects:@"WesternSamoa",nil],
                [NSArray arrayWithObjects:@"Yemen",@"Yugoslavia",nil],
                [NSArray arrayWithObjects:@"Zaire",@"Zambia",@"Zimbabwe", nil],
                nil];
    }
}

// 热门国家
+ (NSArray*)hotCountries {
    if ([self isChineseLanguage]) {
        return [NSArray arrayWithObjects:@"中国",@"美国",@"香港",@"澳门",@"日本",@"台湾",@"韩国",@"新加坡",@"澳大利亚",@"加拿大",@"英国",@"法国",@"德国",@"意大利", nil];
    }else{
        return [NSArray arrayWithObjects:@"China",@"USA",@"Hongkong",@"Macao",@"Japan",@"Taiwan",@"Korea",@"Singapore",@"Australia",@"Canada",@"UK",@"France",@"Germany",@"Italy", nil];
    }
}

// 热门国家代码
+ (NSArray*)hotCountryCodes {
    if ([self isChineseLanguage]) {
        return [NSArray arrayWithObjects:@"86",@"1",@"852",@"853",@"81",@"886",@"82",@"65",@"61",@"1",@"44",@"33",@"49",@"39", nil];
    }else{
        return [NSArray arrayWithObjects:@"86",@"1",@"852",@"853",@"81",@"886",@"82",@"65",@"61",@"1",@"44",@"33",@"49",@"39", nil];
    }
}

// 热门国家英文简写
+ (NSArray*)hotCountryCodes_Alpha {
    if ([self isChineseLanguage]) {
        return [NSArray arrayWithObjects:@"CN",@"US",@"JP",@"KR",@"CA",@"AU",@"GB",@"FR",@"IT",@"DE",@"TH",@"SG",@"RUS",@"NZ", nil];
    }else{
        return [NSArray arrayWithObjects:@"CN",@"US",@"JP",@"KR",@"CA",@"AU",@"GB",@"FR",@"IT",@"DE",@"TH",@"SG",@"RUS",@"NZ", nil];
    }
}

// 国内省市区对象
+ (RegionModel*)domesticDistricts {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    if (filePath == nil) {
        // 兼容cocoapods
        filePath = [PodHelper getOtherResourcePath:@"address" type:@"json" class:[self class]];
    }
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    err == nil ? : NSLog(@"%@", err);
    NSError *jerror;
    RegionModel *addressModel = [[RegionModel alloc] initWithDictionary:dict error:&jerror];
    jerror == nil ? : NSLog(@"%@", jerror);
    return addressModel;
}

@end
