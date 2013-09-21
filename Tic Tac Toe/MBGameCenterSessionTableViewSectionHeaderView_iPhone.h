//
//  MBGameCenterSessionTableViewSectionHeaderView_iPhone.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 21.09.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBGameCenterSessionTableViewSectionHeaderView_iPhone : UIView {
    IBOutlet UILabel *sectionNameLabel;
}

- (void)setSectionName:(NSString *)name;
- (NSString *)sectionName;

@end
