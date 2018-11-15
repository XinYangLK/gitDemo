//
//  ViewController.m
//  tableTest
//
//  Created by 科pro on 2018/10/19.
//  Copyright © 2018年 palmble. All rights reserved.
//

#import "ViewController.h"
#import "TableViewFieldCell.h"
#import "UITextField+IndexPath.h"
//获取宽高
#define MainScreen_width  ([UIScreen mainScreen].bounds.size.width)//宽
#define MainScreen_height ([UIScreen mainScreen].bounds.size.height)//高

//定义一个Block
typedef void (^RunloopBlock)(void);

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *arrayDataSouce;


//***  装任务的数组  **/
@property (nonatomic, strong) NSMutableArray *tasks;
//***  最大任务的数  **/
@property (assign, nonatomic) NSUInteger macQueueLength;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRunLoopObserver];
    
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(100, 100, 100, 100);
    btn.backgroundColor =[UIColor purpleColor];
    btn.titleLabel.font =[UIFont systemFontOfSize:14];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    _tasks = [NSMutableArray array];
    _macQueueLength = 22;
    
    [self.view addSubview:self.tableView];
    
    NSMutableArray *arr =[NSMutableArray arrayWithObjects:@"3",@"100",@"17",@"28",@"25",@"39",@"36", nil];
    //***   冒泡排序  **/
    [self bubbleSort:arr];
    //***  选择排序  **/
    [self selectionSort:arr];
    //***  插入排序  **/
    [self insertionSort:arr];
    //***  快速排序  **/
    [self quickAscendingOrderSort:arr leftIndex:0 rightIndex:6];
    //***  堆排序  **/
    [self heapsortAsendingOrderSort:arr];


    
    NSArray *array =@[
                      @[@2, @3, @4, @8],
                      @[@5, @7, @9, @12],
                      @[@1, @0, @6, @10]
                      ];
    [self spiralMatrix:array];
}
#pragma mark -  冒泡排序
- (void)bubbleSort:(NSMutableArray *)arr{
    
    for (int i=0; i<arr.count-1; i++) {
        for (int j=0; j<arr.count-1-i; j++) {
            //比较次数
            if([arr[j]intValue] > [arr[j+1] intValue]){
                //if判断这里">"为升序排序   "<"为降序排序
                int temp = [arr[j]intValue];
                arr[j]=arr[j+1];
                arr[j+1]=[NSString stringWithFormat:@"%d",temp];
            }
        }
    }
    NSLog(@"冒泡排序: %@",arr);
}
#pragma mark -  选择排序
- (void)selectionSort:(NSMutableArray *)arr {
    for (int i = 0; i < arr.count; i ++) {
        for (int j = i + 1; j < arr.count; j ++) {
            if([arr[i] intValue] > [arr[j] intValue]){
                 //if判断这里">"为升序排序   "<"为降序排序
                int temp =[arr[i] intValue];
                arr[i] = arr[j];
                arr[j] = [NSString stringWithFormat:@"%d",temp];
            }
        }
    }
    NSLog(@"选择排序: %@",arr);
}
#pragma mark -  插入排序
- (void)insertionSort:(NSMutableArray *)arr {
    for (int i = 1; i < arr.count; i ++) {
        NSInteger temp = [arr[i] integerValue];
        for (NSInteger j = i-1; j>=0 && temp > [arr[j] integerValue]; j--) {
             //if判断 temp 这里 ">"为降序排序  "<"为升序排序
            arr[j + 1] = arr[j];
            arr[j] = [NSString stringWithFormat:@"%ld",temp];
        }
    }
    NSLog(@"插入排序: %@",arr);
}

#pragma mark -  快速排序
- (void)quickAscendingOrderSort:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right {
    
    if (left <= right) {
        NSInteger temp = [self getMiddleIndex:arr leftIndex:left rightIndex:right];
        [self quickAscendingOrderSort:arr leftIndex:left rightIndex:temp - 1];
        [self quickAscendingOrderSort:arr leftIndex:temp + 1 rightIndex:right];
    }
    NSLog(@"快速升序排序结果：%@", arr);

}

- (NSInteger)getMiddleIndex:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    NSInteger tempValue = [arr[left] integerValue];
    while (left < right) {
        while (left < right && tempValue <= [arr[right] integerValue]) {
            right --;
        }
        if (left < right) {
            arr[left] = arr[right];
        }
        while (left < right && [arr[left] integerValue] <= tempValue) {
            left ++;
        }
        if (left < right) {
            arr[right] = arr[left];
        }
    }
    arr[left] = [NSNumber numberWithInteger:tempValue];
    return left;
}


#pragma mark - 堆排序
- (void)heapsortAsendingOrderSort:(NSMutableArray *)ascendingArr
{
    NSInteger endIndex = ascendingArr.count - 1;
    ascendingArr = [self heapCreate:ascendingArr];
    while (endIndex >= 0) {
        //  NSLog(@"将list[0]:\%@与list[\(endIndex)]:\%@交换", ascendingArr[0], ascendingArr[endIndex]);
        NSNumber *temp = ascendingArr[0];
        ascendingArr[0] = ascendingArr[endIndex];
        ascendingArr[endIndex] = temp;
        endIndex -= 1;
        ascendingArr = [self heapAdjast:ascendingArr withStartIndex:0 withEndIndex:endIndex + 1];
    }
    NSLog(@"堆排序结果：%@", ascendingArr);
}

- (NSMutableArray *)heapCreate:(NSMutableArray *)array
{
    NSInteger i = array.count;
    while (i > 0) {
        array = [self heapAdjast:array withStartIndex:i - 1 withEndIndex:array.count];
        i -= 1;
    }
    return array;
}

- (NSMutableArray *)heapAdjast:(NSMutableArray *)items withStartIndex:(NSInteger)startIndex withEndIndex:(NSInteger)endIndex
{
    NSNumber *temp = items[startIndex];
    NSInteger fatherIndex = startIndex + 1;
    NSInteger maxChildIndex = 2 * fatherIndex;
    while (maxChildIndex <= endIndex) {
        if (maxChildIndex < endIndex && [items[maxChildIndex - 1] floatValue] < [items[maxChildIndex] floatValue]) {
            maxChildIndex++;
        }
        if ([temp floatValue] < [items[maxChildIndex - 1] floatValue]) {
            items[fatherIndex - 1] = items[maxChildIndex - 1];
        } else {
            break;
        }
        fatherIndex = maxChildIndex;
        maxChildIndex = fatherIndex * 2;
    }
    items[fatherIndex - 1] = temp;
    return items;
}























- (void)spiralMatrix:(NSArray *)matrix{
    
    int tR = 0;// top row
    int tC = 0;// top column
    int dR = (int)matrix.count - 1;//down row
    NSArray *arr = matrix[0];
    int dC = (int)arr.count - 1;//down column

    while (tR <= dR && tC <= dC) {//有等于号
        [self printEdge:matrix withTR:tR++ withTC: tC withDR:dR-- withDC:dC--];
    }
}

- (void)printEdge:(NSArray *)matrix withTR:(NSInteger)tR withTC:(NSInteger)tC
           withDR:(NSInteger)dR  withDC:(NSInteger)dC{
    if (tR == dR) {// 只有一行的时候
        for (NSInteger i = tC; i <= dC; i++) {
            NSLog(@"%@",matrix[tR][i]);
        }
    }
    else if (tC == dC) {// 只有一列的时候
        
        for (NSInteger i = tR; i <= dR; i++) {
            NSLog(@"%@", matrix[i][tC]);
        }
    }
    else {
        NSInteger curC = tC-1; NSInteger curR = tR;
        NSLog(@"-------%ld",dC);
        while (curC != dC) {// 从左到右打印
            curC++;
            NSLog(@"%@",matrix[tR][curC]);
        }
        while (curR != dR) {// 从上往下打印
            curR++;
            NSLog(@"%@",matrix[curR][dC]);
        }
        while (curC != tC) {// 从右往左打印
            curC--;
            NSLog(@"%@",matrix[dR][curC]);
        }
        while (curR != tR) {// 从下往上打印
            
            curR--;
            NSLog(@"%@====%ld===%ld",matrix[curR][tC],curR,tR);
        }
    }
}




//-(NSInteger)getWithm:(NSInteger)m nArr:(NSMutableArray *)arr{
//
//    NSMutableArray *MArray = [[NSMutableArray alloc]init];
//    for(int i=0;(void)(i<arr.count),i++;){
//        [MArray addObject:[NSNumber numberWithInt:i]];
//    }
//    NSMutableArray *resultMArray = [[NSMutableArray alloc]init];
//
//    resultMArray =[self resultMarray:MArray  chooseCount: m];
//
//    return  resultMArray.count;
//}
//
//- (NSMutableArray *)resultMarray:(NSMutableArray *)array chooseCount:(NSInteger)m
//{
//    NSInteger n = [array count];
//    if (m > n)
//    {
//        return nil;
//    }
//    NSMutableArray *allChooseArray = [[NSMutableArray alloc]init];
//
//    NSMutableArray *retArray = [array copy];
//    for(int i=0;i < n;i++)
//    {
//        if (i < m)
//        {
//            [array replaceObjectAtIndex:i withObject:@"1"];
//        }
//        else
//        {
//            [array replaceObjectAtIndex:i withObject:@"0"];
//        }
//    }
//    NSMutableArray *firstArray = [[NSMutableArray alloc]init];
//
//    for(int i=0; i<n; i++)
//    {
//        if ([[array objectAtIndex:i]intValue] == 1)
//        {
//            [firstArray addObject:[retArray objectAtIndex:i]];
//        }
//    }
//    [allChooseArray addObject:firstArray];
//    int count = 0;
//    for(int i = 0; i < n-1; i++)
//    {
//        if ([[array objectAtIndex:i]intValue] == 1 && [[array objectAtIndex:(i + 1)] intValue] == 0)
//        {
//            [array replaceObjectAtIndex:i withObject:@"0"];
//            [array replaceObjectAtIndex:(i + 1) withObject:@"1"];
//            for (int k = 0; k < i; k++)
//            {
//                if ([[array objectAtIndex:k]intValue] == 1)
//                {
//                    count ++;
//                }
//            }
//            if (count > 0)
//            {
//                for (int k = 0; k < i; k++)
//                {
//                    if (k < count)
//                    {
//                        [array replaceObjectAtIndex:k withObject:@"1"];
//                    }
//                    else
//                    {
//                        [array replaceObjectAtIndex:k withObject:@"0"];
//                    }
//                }
//            }
//            NSMutableArray *middleArray = [[NSMutableArray alloc]init];
//            for (int k = 0; k < n; k++)
//            {
//                if ([[array objectAtIndex:k]intValue] == 1)
//                {
//                    [middleArray addObject:[retArray objectAtIndex:k]];
//                }
//            }
//            [allChooseArray addObject:middleArray];
//            i = -1;
//            count = 0;
//        }
//    }
//    return allChooseArray;
//}





- (NSMutableArray *)arrayDataSouce{
    if (!_arrayDataSouce) {
        _arrayDataSouce = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil]; // 注意：初始化时，一定要注意占位，否则第一次去的时候为nil，奔溃
    }
    return _arrayDataSouce;
}

//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
        
        [_tableView registerClass:[TableViewFieldCell class] forCellReuseIdentifier:NSStringFromClass([TableViewFieldCell class])];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewFieldCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewFieldCell class])];
   
    __weak __typeof(&*self) weakSelf = self;
    [self addTask:^{
        cell.textField.placeholder = weakSelf.dataArray[indexPath.row];
        [cell.textField addTarget:weakSelf action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }];
    if (self.arrayDataSouce.count>0) {//避免textField输入字符随cell复用改变
        [cell setTitleString:nil andDataString:self.arrayDataSouce[indexPath.row] andIndexPath:indexPath];
    }
    
    return cell;
}

- (void)textFieldEditChanged:(UITextField *)textField{
    // 数据源赋值
    NSIndexPath *indexPath = textField.indexPath;
    [self.arrayDataSouce replaceObjectAtIndex:indexPath.row withObject:textField.text];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ------ <关于RunLoop的代码>

- (void)addTask:(RunloopBlock)task {
    [self.tasks addObject:task];
    if (self.tasks.count > self.macQueueLength) {
        //干掉最开始的任务
        [self.tasks removeObjectAtIndex:0];
    }
}


static void Callback(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void*info){

    //取出任务执行
    ViewController *vc = (__bridge ViewController *)info;
    if (vc.tasks.count == 0) {
        return;
    }
    RunloopBlock task = vc.tasks.firstObject;
    task();
    [vc.tasks removeObjectAtIndex:0];
    
    
}
//添加Runloop
- (void)addRunLoopObserver{
    //    CFRunLoopGetMain()     拿到主线程的RunLoop
    //    CFRunLoopGetCurrent()  拿到当前的RunLoop
    /**
     * 拿到当前的RunLoop
     * RunLoopRef Ref结尾的代表指针
     */
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL,
    };
    //定义一个观察者
    static CFRunLoopObserverRef defaulModeObserver;
    //创建一个观察者
    defaulModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &Callback, &context);
    //添加RunLoop到观察者！
    CFRunLoopAddObserver(runloop, defaulModeObserver, kCFRunLoopCommonModes);
    //C语言有Creat , 就需要elease
    CFRelease(defaulModeObserver);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
