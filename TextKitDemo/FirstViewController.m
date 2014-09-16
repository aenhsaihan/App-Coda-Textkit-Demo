//
//  FirstViewController.m
//  TextKitDemo
//
//  Created by Anar Enhsaihan on 9/15/14.
//  Copyright (c) 2014 Citta LLC. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic, strong) NSString *styleApplied;
-(void)textSizeChangedWithNotification:(NSNotification *)notification;
-(void)applyStyleToSelection:(NSString *)style;
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textSizeChangedWithNotification:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    self.imageView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)applyHeadlineStyle:(id)sender
{
    [self applyStyleToSelection:UIFontTextStyleHeadline];
}

- (IBAction)applySubHeadlineStyle:(id)sender {
    [self applyStyleToSelection:UIFontTextStyleSubheadline];
}

- (IBAction)applyBodyStyle:(id)sender {
    [self applyStyleToSelection:UIFontTextStyleBody];
}

- (IBAction)applyFootnoteStyle:(id)sender {
    [self applyStyleToSelection:UIFontTextStyleFootnote];
}

- (IBAction)applyCaption1Style:(id)sender {
    [self applyStyleToSelection:UIFontTextStyleCaption1];
}

- (IBAction)applyCaption2Style:(id)sender {
    [self applyStyleToSelection:UIFontTextStyleCaption2];
}

-(void)textSizeChangedWithNotification:(NSNotification *)notification
{
    [self.textView setFont:[UIFont preferredFontForTextStyle:self.styleApplied]];
}

-(void)applyStyleToSelection:(NSString *)style
{
    // 1. Get the range of the selected text.
    NSRange range = [self.textView selectedRange];
    
    // 2. Create a new font with the selected text style.
    UIFont *styledFont = [UIFont preferredFontForTextStyle:style];
    
    // 3. Begin editing the text storage.
    [self.textView.textStorage beginEditing];
    
    // 4. Create a dictionary with the new font as the value and the NSFontAttributeName property as a key.
    NSDictionary *dict = @{NSFontAttributeName : styledFont};
    
    // 5. Set the new attributes to the text storage object of the selected text.
    [self.textView.textStorage setAttributes:dict range:range];
    
    // 6. Notify that we end editing the text storage.
    [self.textView.textStorage endEditing];
}

-(IBAction)toggleImage:(id)sender
{
    if ([self.imageView isHidden]) {
        CGRect convertedFrame = [self.textView convertRect:self.imageView.frame fromView:self.view];
        [[self.textView textContainer] setExclusionPaths:@[[UIBezierPath bezierPathWithRect:convertedFrame]]];
    } else {
        [[self.textView textContainer] setExclusionPaths:nil];
    }
    
    self.imageView.hidden = ![self.imageView isHidden];
}

@end
