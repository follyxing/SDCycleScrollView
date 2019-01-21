//
//  SDCollectionViewAppStoreStyleFlowLayout.m
//  SDCycleScrollView
//
//  Created by 邢程 on 2019/1/15.
//

#import "SDCollectionViewAppStoreStyleFlowLayout.h"

@implementation SDCollectionViewAppStoreStyleFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = 0.003;
    
}
-(void)setItemSize:(CGSize)itemSize{
    super.itemSize = CGSizeMake(itemSize.width-40, itemSize.height);
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
    
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //获取UICollectionView停止的时候的可视范围
    NSLog(@"%f",velocity.x);
    
    CGRect contentFrame;
    contentFrame.size = self.collectionView.frame.size;
    contentFrame.origin = proposedContentOffset;
    NSArray *array = [self layoutAttributesForElementsInRect:contentFrame];// 计算在可视范围的距离中心线最近的Item ABC()为系统取绝对值的函数
    CGFloat minCenterX = CGFLOAT_MAX;
    CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    if (fabs(velocity.x)>.25) {
        NSInteger index = velocity.x>0?1:0;
        UICollectionViewLayoutAttributes *attrs = [array objectAtIndex:index];
        minCenterX = attrs.center.x - collectionViewCenterX;
    }else{
        for (UICollectionViewLayoutAttributes *attrs in array) {
            if(ABS(attrs.center.x - collectionViewCenterX) < ABS(minCenterX)){
                minCenterX = attrs.center.x - collectionViewCenterX;
                
            }
            
        }//补回ContentOffset，则正好将Item居中显示
    }

    return CGPointMake(proposedContentOffset.x + minCenterX, proposedContentOffset.y);
    
}
    

@end

