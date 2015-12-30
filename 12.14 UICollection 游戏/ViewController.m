//
//  ViewController.m
//  12.14 UICollection 游戏
//
//  Created by DC017 on 15/12/14.
//  Copyright © 2015年 DC017. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collection;
    NSString * CellIdenntifier;
    UILabel * daoJiShiXianShi;
    //随机不同色块
    int value;
    //随机颜色
    int yanse1;
    int yanse2;
    int yanse3;
    float f1;
    float f2;
    float f3;
    BOOL kongZhiCellZhiXing;
    UIButton * kaiShi;
    NSTimer * timer;
    int shijian;
    int jiSuanGuanShu;
    
    UILabel * guanShu;
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dingBuLayout];
    
     CellIdenntifier=@"cellI";
    //随机数
    //随机cell 下标
    
    
    [self layout];
    jiSuanGuanShu=1;
    
  }

-(void)dingBuLayout{
    UILabel * daoJiShiBiaoQian=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 60, 20)];
    UILabel * guanShuBiaoQian=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 60, 20)];
    daoJiShiXianShi=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, 60, 20)];
    guanShu=[[UILabel alloc]initWithFrame:CGRectMake(160, 20, 60, 20)];
    guanShu.textColor=[UIColor orangeColor];
    guanShuBiaoQian.textColor=[UIColor redColor];
    guanShuBiaoQian.text=@"关数:";
    
    daoJiShiBiaoQian.textColor=[UIColor redColor];
    daoJiShiBiaoQian.text=@"倒计时:";
    
    
    daoJiShiXianShi.textColor=[UIColor orangeColor];
    //daoJiShi.layer.borderWidth=2;
    //daoJiShi.layer.borderColor=[UIColor brownColor].CGColor;
    
    kaiShi=[[UIButton alloc]initWithFrame:CGRectMake(300, 20, 60, 20)];
    
    [kaiShi setTitle:@"开始" forState:UIControlStateNormal];
    [kaiShi setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    kaiShi.layer.borderWidth=2;
    kaiShi.layer.borderColor=[UIColor orangeColor].CGColor;
    
    [kaiShi addTarget:self action:@selector(KaiShiShiJian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:daoJiShiXianShi];
    [self.view addSubview:daoJiShiBiaoQian];
    [self.view addSubview:kaiShi];
    [self.view addSubview:guanShuBiaoQian];
    [self.view addSubview:guanShu];
    
    
    
   
}

-(void)layout{
     UICollectionViewFlowLayout *bujufangan=[[UICollectionViewFlowLayout alloc]init];
     collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 70,375,677)collectionViewLayout:bujufangan];
     collection.backgroundColor=[UIColor whiteColor];
     collection.delegate=self;
     collection.dataSource=self;
     [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdenntifier];
     [self.view addSubview:collection];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdenntifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:f1 green:f2 blue:f3 alpha:1];
    if (indexPath.row==value) {
        cell.backgroundColor=[UIColor colorWithRed:f1-0.2 green:f2-0.2 blue:f3-0.2 alpha:1];
        
    }
    
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 66;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self layout];
   
    
    if (indexPath.row==value) {
        
        value = arc4random() % 66;
        yanse1=arc4random()%67;
        yanse2=arc4random()%67;
        yanse3=arc4random()%67;
        f1=(float)yanse1/67;
        f2=(float)yanse2/67;
        f3=(float)yanse3/67;
        ++jiSuanGuanShu;
        guanShu.text=[NSString stringWithFormat:@"%i",jiSuanGuanShu];
        
    }
   
    NSLog(@" value:%i       f1:%f   f2:%f    f3:%f",value, f1,f2,f3);

}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return kongZhiCellZhiXing;
}
-(void)KaiShiShiJian{
    kongZhiCellZhiXing=YES;
    NSLog(@"%i",kongZhiCellZhiXing);
    
    value = arc4random() % 67;
    yanse1=arc4random()%67;
    yanse2=arc4random()%67;
    yanse3=arc4random()%67;
    f1=(float)yanse1/67;
    f2=(float)yanse2/67;
    f3=(float)yanse3/67;
    [self layout];
    
    kaiShi.hidden=YES;
    //倒计时时间设置
    shijian=60;
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    
    daoJiShiXianShi.text=[NSString stringWithFormat:@"%i",shijian];
    guanShu.text=[NSString stringWithFormat:@"%i",jiSuanGuanShu];

    
    
}
-(void)daojishi{
    shijian--;
    if (shijian==0) {
        [timer invalidate];
        timer=nil;
        
        //弹出框
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Game Over" message:[NSString stringWithFormat:@"恭喜你闯到%@",guanShu.text] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            
            f1=0;
            f2=0;
            f3=0;
            //注意这才是刷新
            
            kaiShi.hidden=NO;
            kongZhiCellZhiXing=NO;
            jiSuanGuanShu=1;
            guanShu.text=@"";
            value=-1;
            [collection reloadData];
           
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    daoJiShiXianShi.text=[NSString stringWithFormat:@"%i",shijian];
    NSLog(@"%@",daoJiShiXianShi.text);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
