//
//  ALFLEXBOXUtils.m
//  all_layouts
//
//  Created by xiekw on 15/7/6.
//  Copyright (c) 2015年 xiekw. All rights reserved.
//

#import "Placeholder.h"

static NSString * const kEnglishContent = @"The Réunion parrot or Dubois's parrot (Necropsittacus borbonicus) is a hypothetical extinct species of parrot based on descriptions of birds from the Mascarene island of Réunion. Its existence has been inferred from the travel report of Dubois in 1674 who described it as having a Body the size of a large pigeon, green; head, tail and upper part of wings the colour of fire. No remains have been found of this supposed species, and its existence seems doubtful.";

static NSString * const kChineseContent = @"盼望着，盼望着，东风来了，春天的脚步近了。一切都象刚睡醒的样子，欣欣然张开了眼。山朗润起来了，水涨起来了，太阳的脸红起来了。\n小草偷偷地从土里钻出来，嫩嫩的，绿绿的。园子里，田野里，瞧去，一大片一大片满是的。坐着，趟着，打两个滚，踢几脚球，赛几趟跑，捉几回迷藏。风轻悄悄的，草软绵绵的。\n桃树、杏树、梨树，你不让我，我不让你，都开满了花赶趟儿。红的像火，粉的像霞，白的像雪。花里带着甜味儿，闭了眼，树上仿佛已经满是桃儿、杏儿、梨儿！花下成千成百的蜜蜂嗡嗡地闹着，大小的蝴蝶飞来飞去。野花遍地是：杂样儿，有名字的，没名字的，散在草丛里像眼睛，像星星，还眨呀眨的。\n“吹面不寒杨柳风”，不错的，像母亲的手抚摸着你。风里带来些新翻的泥土气息，混着青草味儿，还有各种花的香都在微微润湿的空气里酝酿。鸟儿将窠巢安在繁花嫩叶当中，高兴起来了，呼朋引伴地卖弄清脆的喉咙，唱出宛转的曲子，与轻风流水应和着。牛背上牧童的短笛，这时候也成天嘹亮地响。\n雨是最寻常的，一下就是两三天。可别恼。看，像牛毛，像花针，像细丝，密密地斜织着，人家屋顶上全笼着一层薄烟。树叶子却绿得发亮，小草儿也青得逼你的眼。傍晚时候，上灯了，一点点黄晕的光，烘托出一片安静而和平的夜。乡下去，小路上，石桥边，有撑起伞慢慢走着的人；还有地里工作的农夫，披着蓑，戴着笠。他们的房屋，稀稀疏疏的，在雨里静默着。\n天上风筝渐渐多了，地上孩子也多了。城里乡下，家家户户，老老小小，也赶趟儿似的，一个个都出来了。舒活舒活筋骨，抖擞精神，各做各的一份儿事去了。“一年之计在于春”，刚起头儿，有的是工夫，有的是希望。\n春天像刚落地的娃娃，从头里脚是新的，它生长着。\n春天像小姑娘，花枝招展的，笑着，走着。\n春天像健壮的青年，有铁一般的胳膊和腰脚，领着我们上前去。";

static inline CGFloat RandomFloatBetweenLowAndHigh(CGFloat low, CGFloat high) {
    CGFloat diff = high - low;
    return (((CGFloat) rand() / RAND_MAX) * diff) + low;
}

static inline NSString *RandomUserName() {
    NSMutableString *ms = [NSMutableString new];
    for (u_int32_t i = 0; i < arc4random_uniform(10) + 5; ++i) {
        [ms appendFormat:@"%c", arc4random_uniform('z' - 'a') + 'a'];
    }
    return ms;
}

static inline BOOL RandomBool() {
    return arc4random_uniform(2) == 1;
}

static inline NSUInteger RandomIntBetweenLowAndHigh(NSUInteger low, NSUInteger high) {
    u_int32_t diff = (u_int32_t)(high - low);
    return (arc4random_uniform(diff)) + low;
}

static inline NSString *RandomTextWithRange(NSInteger min, NSInteger max, NSString *sample) {
    NSInteger textLength = sample.length;
    NSInteger location = RandomIntBetweenLowAndHigh(0, textLength);
    NSInteger length = MIN(RandomIntBetweenLowAndHigh(min, max), textLength - location);
    
    return [sample substringWithRange:NSMakeRange(location, length)];
}

static inline NSArray *RandomObjectArrayWithRandomCountBetween(NSUInteger low, NSUInteger high, id (^create)()) {
    NSUInteger count = RandomIntBetweenLowAndHigh(low, high);
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i ++) {
        id obj;
        if (create) {
            obj = create();
        }
        if (!obj) {
            obj = RandomTextWithRange(2, 10, kEnglishContent);
        }
        [mArray addObject:obj];
    }
    return mArray;
}

static inline NSDateFormatter *dateFormatter() {
    static dispatch_once_t onceToken;
    static NSDateFormatter *formatter = nil;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"y-L-d, H:m:s"];
    });
    
    return formatter;
}

@implementation UIColor (PH_Colorful)

+ (UIColor *)randomColor {
    return [self randomColorWithAlpha:1.0];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

@implementation Placeholder

+ (NSArray *)kImageURLS {
    static dispatch_once_t onceToken;
    static NSArray *imageURLs;
    dispatch_once(&onceToken, ^{
        imageURLs = @[@"http://g.hiphotos.baidu.com/image/h%3D360/sign=fdcf1ae05eafa40f23c6c8db9b65038c/562c11dfa9ec8a13ed18fa32f303918fa1ecc0e6.jpg",
                      @"http://b.hiphotos.baidu.com/image/h%3D360/sign=19e72ad5d02a28345ca6300d6bb7c92e/e61190ef76c6a7efb7a592eef9faaf51f2de6672.jpg",
                      @"http://d.hiphotos.baidu.com/image/h%3D360/sign=c6bc69d576f08202329297397bf9fb8a/63d9f2d3572c11dfc21b32d5662762d0f603c27a.jpg",
                      @"http://f.hiphotos.baidu.com/image/h%3D360/sign=1c9a50843ec79f3d90e1e2368aa0cdbc/f636afc379310a5566becb8fb24543a982261036.jpg",
                      @"http://f.hiphotos.baidu.com/image/h%3D360/sign=c3596956f4246b60640eb472dbf81a35/b90e7bec54e736d1527ebb0d99504fc2d5626941.jpg",
                      @"http://g.hiphotos.baidu.com/image/w%3D310/sign=cf2be2c63ddbb6fd255be3273925aba6/8b82b9014a90f603ed7cca7a3d12b31bb051ed3b.jpg",
                      @"http://b.hiphotos.baidu.com/image/w%3D310/sign=69a9abb2249759ee4a5066ca82fa434e/d439b6003af33a878803cfa5c45c10385343b527.jpg",
                      @"http://d.hiphotos.baidu.com/image/w%3D310/sign=6a067b15ab014c08193b2ea43a7a025b/bf096b63f6246b608f1144c8e9f81a4c510fa26b.jpg",
                      @"http://h.hiphotos.baidu.com/image/w%3D310/sign=fd959d3de9c4b7453494b117fffd1e78/0bd162d9f2d3572ce61f87c88813632762d0c321.jpg"
                      ];
    });
    return imageURLs;
}

+ (NSString *)textWithRange:(NSRange)range {
    NSUInteger min = range.location;
    NSUInteger max = range.length;
    return RandomTextWithRange(min, max, kEnglishContent);
}

+ (UIImage *)imageWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor randomColor] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSString *)imageURL {
    NSArray *imageURLs = [self kImageURLS];
    return imageURLs[arc4random_uniform((u_int32_t)imageURLs.count)];
}

@end

@implementation PlaceholderModel

+ (instancetype)randomModel {
    return [[self class] new];
}

+ (NSArray *)randomModelWithRange:(NSRange)range {
    NSUInteger min = range.location;
    NSUInteger max = range.length;
    
    return RandomObjectArrayWithRandomCountBetween(min, max, ^id{
        return [[self class] randomModel];
    });
}

+ (void)asyncRandomModelWithRange:(NSRange)range completionBlock:(PlaceholderBlock)block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RandomFloatBetweenLowAndHigh(2, 10.0) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL needError = arc4random_uniform(10) == 1;
        NSError *error = needError ? [NSError new] : nil;
        NSArray *objects = nil;
        if (!needError) {
            objects = [[self class] randomModelWithRange:range];
        }
        block(objects, error);
    });
}

@end

@implementation PHFeedUser

+ (instancetype)randomModel {
    PHFeedUser *user = [[self class] new];
    user.username = RandomUserName();
    user.bio = RandomBool() ? RandomTextWithRange(5, 140, kEnglishContent) : nil;
    user.avatarURL = [Placeholder imageURL];
    
    return user;
}

@end

@implementation PHFeedComment

+ (instancetype)randomModel {
    PHFeedComment *comment = [[self class] new];
    comment.user = [PHFeedUser randomModel];
    comment.commentDate = [dateFormatter() stringFromDate:[NSDate date]];
    comment.commentContent = RandomTextWithRange(8, 140, kEnglishContent);
    comment.imageURLs = RandomBool() ? RandomObjectArrayWithRandomCountBetween(2, 9, ^id{
        return [Placeholder imageURL];
    }) : nil;

    return comment;
}

@end

@implementation PHFeed

+ (instancetype)randomModel {
    PHFeed *model = [PHFeed new];
    model.user = [PHFeedUser randomModel];
    model.originPrice = RandomFloatBetweenLowAndHigh(50.0, 10000.0);
    model.currentPrice = RandomFloatBetweenLowAndHigh(50, model.originPrice);
    model.soldedCount = RandomIntBetweenLowAndHigh(50, 100000);
    model.title = RandomTextWithRange(10, 50, kEnglishContent);;
    model.subTitle = RandomTextWithRange(30, 200.0, kEnglishContent);
    model.tags = RandomObjectArrayWithRandomCountBetween(4, 10, ^id{
        return RandomTextWithRange(2, 15, kEnglishContent);
    });
    model.comments = RandomObjectArrayWithRandomCountBetween(10, 50, ^id{
        return [PHFeedComment randomModel];
    });
    model.imageURLs = RandomObjectArrayWithRandomCountBetween(3, 6, ^id{
        return [Placeholder imageURL];
    });
    model.liked = RandomBool();
    
    return model;
}

@end
