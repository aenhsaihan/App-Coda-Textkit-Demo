//
//  SecondViewController.h
//  TextKitDemo
//
//  Created by Anar Enhsaihan on 9/15/14.
//  Copyright (c) 2014 Citta LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)makeBold:(id)sender;
- (IBAction)makeItalic:(id)sender;
- (IBAction)underlineText:(id)sender;
- (IBAction)alignTextLeft:(id)sender;
- (IBAction)centerText:(id)sender;
- (IBAction)alignTextRight:(id)sender;
- (IBAction)makeTextColorRed:(id)sender;
- (IBAction)makeTextColorBlack:(id)sender;

@end
