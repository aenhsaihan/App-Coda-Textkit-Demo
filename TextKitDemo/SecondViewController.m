//
//  SecondViewController.m
//  TextKitDemo
//
//  Created by Anar Enhsaihan on 9/15/14.
//  Copyright (c) 2014 Citta LLC. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
-(void)addOrRemoveFontTraitWithName:(NSString *)traitName andValue:(uint32_t)traitValue;
-(void)setParagraphAlignment:(NSTextAlignment)newAlignment;
-(void)setForegroundColor:(UIColor *)color;
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Font

-(IBAction)makeBold:(id)sender
{
    [self addOrRemoveFontTraitWithName:@"Bold" andValue:UIFontDescriptorTraitBold];
}

-(IBAction)makeItalic:(id)sender
{
    [self addOrRemoveFontTraitWithName:@"Italic" andValue:UIFontDescriptorTraitItalic];
}

-(void)addOrRemoveFontTraitWithName:(NSString *)traitName andValue:(uint32_t)traitValue
{
    NSRange selectedRange = [self.textView selectedRange];
    
    NSDictionary *currentAttributesDict = [self.textView.textStorage attributesAtIndex:selectedRange.location effectiveRange:nil];
    
    UIFont *currentFont = [currentAttributesDict objectForKey:NSFontAttributeName];
    
    UIFontDescriptor *fontDescriptor = [currentFont fontDescriptor];
    
    NSString *fontNameAttribute = [[fontDescriptor fontAttributes] objectForKey:UIFontDescriptorNameAttribute];
    UIFontDescriptor *changedFontDescriptor;
    
    if ([fontNameAttribute rangeOfString:traitName].location == NSNotFound) {
        uint32_t existingTraitsWithNewTrait = [fontDescriptor symbolicTraits] | traitValue;
        changedFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:existingTraitsWithNewTrait];
    } else {
        uint32_t existingTraitsWithoutTrait = [fontDescriptor symbolicTraits] & ~traitValue;
        changedFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:existingTraitsWithoutTrait];
    }
    
    UIFont *updatedFont = [UIFont fontWithDescriptor:changedFontDescriptor size:0.0];
    
    NSDictionary *dict = @{NSFontAttributeName: updatedFont};
    
    [self.textView.textStorage beginEditing];
    [self.textView.textStorage setAttributes:dict range:selectedRange];
    [self.textView.textStorage endEditing];
}

#pragma mark - Underline

-(IBAction)underlineText:(id)sender
{
    NSRange selectedRange = [_textView selectedRange];
    
    NSDictionary *currentAttributesDict = [_textView.textStorage attributesAtIndex:selectedRange.location
                                                                    effectiveRange:nil];
    NSDictionary *dict;
    
    if ([currentAttributesDict objectForKey:NSUnderlineStyleAttributeName] == nil ||
        [[currentAttributesDict objectForKey:NSUnderlineStyleAttributeName] intValue] == 0) {
        
        dict = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInt:1]};
        
    }
    else{
        dict = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInt:0]};
    }
    
    [_textView.textStorage beginEditing];
    [_textView.textStorage setAttributes:dict range:selectedRange];
    [_textView.textStorage endEditing];
}

#pragma mark - Alignment

- (IBAction)alignTextLeft:(id)sender
{
    [self setParagraphAlignment:NSTextAlignmentLeft];
}

- (IBAction)centerText:(id)sender
{
    [self setParagraphAlignment:NSTextAlignmentCenter];
}

- (IBAction)alignTextRight:(id)sender
{
    [self setParagraphAlignment:NSTextAlignmentRight];
}

-(void)setParagraphAlignment:(NSTextAlignment)newAlignment
{
    NSRange selectedRange = [self.textView selectedRange];
    
    NSMutableParagraphStyle *newParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [newParagraphStyle setAlignment:newAlignment];
    
    NSDictionary *dict = @{NSParagraphStyleAttributeName: newParagraphStyle};
    [self.textView.textStorage beginEditing];
    [self.textView.textStorage setAttributes:dict range:selectedRange];
    [self.textView.textStorage endEditing];
}

#pragma mark - Color

- (IBAction)makeTextColorRed:(id)sender
{
    [self setForegroundColor:[UIColor redColor]];
}

- (IBAction)makeTextColorBlack:(id)sender
{
    [self setForegroundColor:[UIColor blackColor]];
}

-(void)setForegroundColor:(UIColor *)color
{
    NSRange selectedRange = [_textView selectedRange];
    
    NSDictionary *currentAttributesDict = [_textView.textStorage attributesAtIndex:selectedRange.location
                                                                    effectiveRange:nil];
    
    if ([currentAttributesDict objectForKey:NSForegroundColorAttributeName] == nil ||
        [currentAttributesDict objectForKey:NSForegroundColorAttributeName] != color) {
        
        NSDictionary *dict = @{NSForegroundColorAttributeName: color};
        [_textView.textStorage beginEditing];
        [_textView.textStorage setAttributes:dict range:selectedRange];
        [_textView.textStorage endEditing];
    }
}

@end
